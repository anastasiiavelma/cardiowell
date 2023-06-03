import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

class SmartEmulator {

    private static final String deviceId = "64786a42761f65ae098487aa";

    private static final int NORMAL_PULSE = 70;

    private static int pulseSensorValue;

    private static final String FILE_PATH = "pulse.txt";


    public static void main(String[] args) {

        Thread run = new Thread(new Runnable() {
            @Override
            public void run() {
                while(true){
                    try {
                        simulateSensorData();
                        processStored();
                        sendDataToBackend(pulseSensorValue);

                        Thread.sleep(1000*60);
                    } catch (InterruptedException ex) {
                        System.out.println("An error: " + ex.getMessage());
                    }
                }
            }
        });
        run.start();
    }

    private static void simulateSensorData() {
        Random random = new Random();
        pulseSensorValue = NORMAL_PULSE + random.nextInt(40) - 15;
    }


    private static void sendDataToBackend(int pulseSensorValue) {
        try {
            URL url = new URL("http://localhost:5000/device-result");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json");

            String postData = "{\n" +
                    "  \"deviceId\": \"" + deviceId + "\",\n" +
                    "  \"value\": " + pulseSensorValue + ",\n" +
                    "  \"dateTime\": \"" + new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime()) + "\"\n" +
                    "}";

            try (OutputStream outputStream = connection.getOutputStream()) {
                byte[] postDataBytes = postData.getBytes(StandardCharsets.UTF_8);
                outputStream.write(postDataBytes);
                outputStream.flush();
            }

            int responseCode = connection.getResponseCode();
            isServerResponsive(responseCode);
            connection.disconnect();
        } catch (IOException e) {
            System.out.println("An error occurred while sending score to the backend: " + e.getMessage());
            storeLocally();
        }
    }

    private static void isServerResponsive(int responseCode) {
        if (responseCode == HttpURLConnection.HTTP_CREATED) {
            System.out.println("Score sent to the backend successfully.");
        } else {
            System.out.println("Failed to send score to the backend. Response code: " + responseCode);
            storeLocally();
        }
    }

    private static void storeLocally() {
        try {
            String fileName = "pulse.txt";
            FileWriter writer = new FileWriter(fileName, true);

            writer.write(pulseSensorValue + " " + new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime()) + " " + "false" + "\n");
            writer.close();

            System.out.println(" stored locally in the file");
        } catch (IOException e) {
            System.out.println("An error occurred while storing  locally: " + e.getMessage());
        }
    }

    public static void processStored() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            System.out.println("No stored found.");
            return;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            File tempFile = new File(file.getAbsolutePath() + ".tmp");
            while ((line = reader.readLine()) != null) {
                boolean sentToBackend = processPulse(line);
                if (sentToBackend) {
                    FileWriter writer = new FileWriter(tempFile, true);
                    writer.write(line.replace("false", "true") + System.lineSeparator());
                    writer.close();
                }
            }
            reader.close();
            if (file.delete()) {
                if (!tempFile.renameTo(file)) {
                    throw new IOException("Failed to rename the temporary file to the original file.");
                }
            } else {
                throw new IOException("Failed to delete the original file.");
            }
        } catch (IOException e) {
            System.out.println("An error occurred while processing stored scores: " + e.getMessage());
        }
    }

    private static boolean processPulse(String line) {
        String[] parts = line.split(" ");
        if (parts.length != 4) {
            return false;
        }

        int pulseSensorValue = Integer.parseInt(parts[0]);
        String timestamp = parts[1] + " " + parts[2];
        boolean sentToBackend = Boolean.parseBoolean(parts[3]);

        System.out.println(pulseSensorValue);
        System.out.println(timestamp);
        System.out.println(sentToBackend);

        if (!sentToBackend) {
            boolean success = sendDataToBackend(pulseSensorValue, timestamp);
            if (success) {
                System.out.println("sent to the backend: " + pulseSensorValue);
                return true;
            } else {
                System.out.println("Failed send to the backend: " + pulseSensorValue);
            }
        }
        return false;
    }

    private static boolean sendDataToBackend(int pulseSensorValue, String timestamp) {
        try {
            System.out.println(pulseSensorValue);
            System.out.println(timestamp);
            URL url = new URL("http://localhost:5000/device-result");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json");

            String postData = "{\n" +
                    "  \"deviceId\": \"" + deviceId + "\",\n" +
                    "  \"value\": " + pulseSensorValue + ",\n" +
                    "  \"dateTime\": \"" + timestamp + "\"\n" +
                    "}";

            try (OutputStream outputStream = connection.getOutputStream()) {
                byte[] postDataBytes = postData.getBytes(StandardCharsets.UTF_8);
                outputStream.write(postDataBytes);
                outputStream.flush();
            }

            int responseCode = connection.getResponseCode();
            connection.disconnect();
            if (responseCode == HttpURLConnection.HTTP_CREATED) {
                return true;
            } else {
                return false;
            }
        } catch (IOException e) {
            return false;
        }
    }
}
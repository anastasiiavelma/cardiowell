import PostModel from '../models/Post.mjs';

export const create = async (req, res) => {
    try {
    const doc = new PostModel({
        title: req.body.title,
        textInfo: req.body.textInfo,
        imageUrl: req.body.imageUrl,
        user: req.userId,
    })
        const post = await doc.save();

        res.json(post)
    }
    catch(err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed create post'
        })
    }
}

export const getAll = async (req, res) => {
    try{
        const posts = await PostModel.find().populate('user').exec();
        res.json(posts);
    }
    catch(err) {
        console.log(err)
        res.status(500).json({
            message: 'Failed gel all posts'
        })
    }
}

export const getOne = async (req, res) => {
    try {
        const postId = req.params.id;

        const updatedDoc = await PostModel.findOneAndUpdate(
            {
                _id: postId,
            },
            {
                returnDocument: 'after',
            }
        ).populate('user');

        if (!updatedDoc) {
            return res.status(404).json({
                message: 'Post not found',
            });
        }

        res.json(updatedDoc);
    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed posts',
        });
    }
}

export const remove = async (req, res) => {
    try {
        const postId = req.params.id;

        const deletedPost = await PostModel.findOneAndDelete({ _id: postId });

        if (!deletedPost) {
            return res.status(404).json({
                message: 'Post not found',
            });
        }

        res.json({
            success: true,
        });

    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed to remove post',
        });
    }
}

export const update = async (req, res) => {
    try {
        const postId = req.params.id;

        await PostModel.updateOne(
            {
                _id: postId,
            },
            {
                title: req.body.title,
                textInfo: req.body.textInfo,
                imageUrl: req.body.imageUrl,
                user: req.userId,
            },
        );

        res.json({
            success: true,
        });

    } catch (err) {
        console.log(err);
        res.status(500).json({
            message: 'Failed to update post',
        });
    }
}

const jwt = require('jsonwebtoken');

const verifikasiToken = (req, res, next) => {
   try {
        const header = req.headers.authorization;
      
      if (!header || !header.startsWith('Bearer ')) {
            return res.status(401).json({
                message: 'Silakan login terlebih dahulu'
            });
        }
      
         const token = header.split(' ')[1];

         const decoded = jwt.verify(
            token,
            process.env.JWT_SECRET
        );

        req.user = decoded;

        next();

    } catch (error) {
        return res.status(401).json({
            message: 'Token tidak valid atau sudah kedaluwarsa'
        });
    }
};

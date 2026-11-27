const jwt = require('jsonwebtoken');

const verifikasiToken = (req, res, next) => {
   try {
        const header = req.headers.authorization;
      
      if (!header || !header.startsWith('Bearer ')) {
            return res.status(401).json({
                message: 'Silakan login terlebih dahulu'
            });
        }

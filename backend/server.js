const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const multer = require('multer');
const path = require('path');

const app = express();
const PORT = 3000;
const HOST = "192.168.99.139";

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, 'uploads/'),
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});
const upload = multer({ storage });

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'testdb'
});

db.connect((err) => {
  if (err) {
    console.error('Database connection failed: ' + err.stack);
    return;
  }
  console.log('✅ Connected to database.');
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: 'Username and Password are required' });
  }

  const sql = 'SELECT * FROM users WHERE username = ?';
  db.query(sql, [username], async (err, results) => {
    if (err) {
      console.error('Error querying database:', err);
      return res.status(500).json({ message: 'Server error' });
    }

    if (results.length === 0) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    const user = results[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    delete user.password;

    res.json({
      message: 'Login successful',
      user: {
        id: user.id,
        username: user.username,
        f_name: user.f_name,
        l_name: user.l_name,
        role: user.role,
        p_pic: user.p_pic,
      }
    });
  });
});

app.put('/api/users/:id', upload.single('p_pic'), async (req, res) => {
  const { id } = req.params;
  const { f_name, l_name } = req.body;
  const p_pic = req.file ? req.file.filename : null;

  if (!f_name || !l_name) {
    return res.status(400).json({ error: 'First name and last name are required' });
  }

  try {
    const [users] = await db.promise().query('SELECT * FROM users WHERE id = ?', [id]);
    if (users.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    let updateQuery = 'UPDATE users SET f_name = ?, l_name = ?';
    const params = [f_name, l_name];

    if (p_pic) {
      updateQuery += ', p_pic = ?';
      params.push(p_pic);
    }

    updateQuery += ' WHERE id = ?';
    params.push(id);

    await db.promise().query(updateQuery, params);

    res.json({ message: 'Profile updated successfully' });
  } catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).json({ error: 'Server error during profile update' });
  }
});

app.get('/api/users/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const [rows] = await db.promise().query('SELECT id, email, username, role, employee_number, f_name, l_name, p_pic, created_at FROM users WHERE id = ?', [id]);
    if (rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(rows[0]);
  } catch (error) {
    console.error('Error fetching user profile:', error);
    res.status(500).json({ error: 'Server error during profile fetch' });
  }
});

app.listen(PORT, HOST, () => {
  console.log(`🚀 Server running on http://${HOST}:${PORT}`);
});

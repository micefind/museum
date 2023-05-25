const mysql = require('mysql')

const db = mysql.createPool({
  host: '127.0.0.1',
  user: 'root',
  // user: 'mushuai',
  password: 'admin123',
  database: 'museum_db'
})

module.exports = db

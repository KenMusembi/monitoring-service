import db from './db.js'

// get all users
const getUsers = (request, response) => {
    db.query('SELECT * FROM users ORDER BY user_id ASC', (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

// get single user
const getUserById = (request, response) => {
    const user_id = parseInt(request.params.user_id)
  
    db.query('SELECT * FROM users WHERE user_id = $1', [user_id], (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

// create user
const createUser = (request, response) => {
    const { name, email } = request.body
  
    db.query('INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *', [name, email], (error, results) => {
      if (error) {
        throw error
      }
      response.status(201).send(`User added with ID: ${results.rows[0].user_id}`)
    })
  }

// update user
const updateUser = (request, response) => {
    const user_id = parseInt(request.params.user_id)
    const { name, email } = request.body
  
    db.query(
      'UPDATE users SET name = $1, email = $2 WHERE user_id = $3',
      [name, email, user_id],
      (error, results) => {
        if (error) {
          throw error
        }
        response.status(200).send(`User modified with ID: ${user_id}`)
      }
    )
  }

// delete user
const deleteUser = (request, response) => {
    const user_id = parseInt(request.params.user_id)
  
    db.query('DELETE FROM users WHERE user_id = $1', [user_id], (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User deleted with ID: ${user_id}`)
    })
  }

export default {
    getUserById, getUsers, createUser, updateUser, deleteUser,
}  
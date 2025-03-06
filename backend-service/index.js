import express from 'express';
import bodyParser from 'body-parser';
import db from './queries.js'

const app = express()
const port = 5000

app.use(bodyParser.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)

app.get('/users', db.getUsers)
app.get('/users/:id', db.getUserById)
app.post('/users', db.createUser)
app.put('/users/:id', db.updateUser)
app.delete('/users/:id', db.deleteUser)

app.listen(port, () => {
    console.log(`Backend service running on port ${port}.`)
})

app.get('/', (request, response) => {
    response.json({ info: 'OK! Backend APIs Working'})
})
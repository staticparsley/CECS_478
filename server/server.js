'use strict';

const express = require('express')
const jwt = require('jsonwebtoken')
const fs = require('fs')
const bodyparser = require('body-parser')
const crypto = require('crypto')
const scrypt = require('scrypt-for-humans')

const levelup = require('levelup')
var db = levelup('./mydb')

const app = express()

let port = process.env.PORT || 8080

app.use(bodyparser.urlencoded({extended: false}))
app.use(bodyparser.json())

const jwtkey = fs.readFileSync('jwtkey.txt', 'utf8');

app.get("/", (req,res) => {
	res.send('Welcome to Cookie Coders')
})


app.post('/register', function(req,res) {
	
	const usern = req.body.username
	const passw = req.body.password
	if(!usern || !passw) {
		res.json({success: false, msg: 'Please enter username and password'})
	}
	else {
		scrypt.hash(passw, {"N":16,"r":1,"p":1},64,"", function(err, res) {
			console.log(result.toString("hex"));
		});
		
		     res.send("creating user");
	      	 db.put(username, {passwrd: passw , unread: []});

			const payload = {
				sub: uname,
				exp: Math.floor(Date.now() / 1000) + (60 * 60)
			}
					
			jwt.sign(payload, jwtkey, (err, token) => {
				if (err) {
					console.log(err)
					res.send('err thrown')
				} else {
					res.json({token: token})
				}
			})
			}  
		}
	);                   

app.post('/login', (req, res) => {
  const username = req.body.username
  const passw = req.body.password
  
  db.get(username, (err, user) => {
    if (err) {
      console.log(err)
      res.send('invalid username')
    } else {
      const passHash = user.passwordHash
      scrypt.verifyHash(passw, passHash, err => {
        if (err) {
          console.log(err)
          res.send('invalid password')
        }
        const payload = {
          sub: username,
          exp: Math.floor(Date.now() / 1000) + (60 * 60) // 1 hr
        }
        jwt.sign(payload, jwtkey, (err, token) => {
          if (err) {
            console.log(err)
            res.send('err thrown')
          } else {
            res.json({token: token})
          }
        })
      })
    }
  })  
})

app.post('/sendMessage', function(req,res) {
	var data = {
		rec: req.body.rec,
		msg: req.body.msg,
		time: req.body.time
	}
	
	const uname = req.body.username
	const token = req.headers["token"]
	
	if(!uname || !token) {
		res.send({'response': 'Error', 'message': "Wrong inputs"})
	}
	else {
		const decoded = ''
		decoded = jwt.verify(req.headers["token"], secret);
		db.put(rec,{message: msg, stamp: time})
		
	}
})

app.post('/getMessage', function(req,res) {
	const uname = req.body.username
	const token = req.headers["token"]
		
		if(!uname || !token) {
			res.send({'response': 'Error', 'message': "Wrong inputs"})
		}
		else {
			const decoded = ''
			decoded = jwt.verify(req.headers["token"], jwtkey);
			db.get(rec,{message: msg, stamp: time})
			
		}
})


app.listen(port, () => {
  console.log(`server listening on port ${port}`)
})
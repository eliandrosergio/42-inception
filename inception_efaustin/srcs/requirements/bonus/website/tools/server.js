const	express = require('express')
const	app = express()

app.use(express.static('public'))

app.listen(4444, () => {
	console.log("✅ Website estático rodando na porta: 4444")
	console.log("🛡️ Acesse localhost:4444")
})

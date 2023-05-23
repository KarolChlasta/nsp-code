const express = require('express');
const app = express();
const hbs = require('hbs')
const path = require('path')

const viewsPath = path.join(__dirname,'../../templates/views')
const partialsPath = path.join(__dirname,'../../templates/partials')

app.set('views',viewsPath)
app.set('view engine', 'hbs')

hbs.registerPartials(partialsPath)

app.use(express.urlencoded());

app.get('',(req, res) =>{
    res.render('index',{
        title: 'ECS service web page',
        indexText: 'Index text',
        name: 'NSP team',
        people: [
            "Yehuda Katz",
            "Alan Johnson",
            "Charles Jolley",
          ]
    })
})
app.get('/addexp', (req, res) => {
    res.render('addexp',{
        title: 'add experiment page',
        addexpText: 'add experiments page',
        name: 'xxx'
    })

})

app.get('/test',function(req,res,next) {
res.send(`
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/styles.css">
</head>

<body>

<header>
<h1>
add experiment page
</h1>
<div>
    <a href="./runListModels">models</a>
    <a href="./requests">Requests</a>
    <a href="./runListExperiments">Experiments</a>
    <a href="./addexp">add experiment</a>
    <a href="./runShowStats">simulation status</a>
    <a href="./help">help</a>
    <a href="./about">about</a>
</div>
</header> 
<form   action="/" method="post" id="addExpForm" name="addExpForm">
<input id="modelName" name="modelName" type="text" placeholder="modelName"/> 
<input id="simSuffix" name="simSuffix" type="text" placeholder="simSuffix"/> 
<input id="simDesc" name="simDesc" type="text" placeholder="simDesc"/> 
<input id="simTimeStepInSec" name="simTimeStepInSec" type="text" placeholder="simTimeStepInSec"/> 
<input id="parallelMode" name="parallelMode" type="text" placeholder="parallelMode"/> 
<input id="numNodes" name="numNodes" type="text" placeholder="numNodes"/> 
<button>Run experiments</button>

</form>

<footer>
<div>
   created by HPI project 
</div>
</footer>
</body>
</html>
`);
}
)

app.listen(2000)

app.post('/', (req, res) => {
    
    var data = req.body;
    console.log('post js');
    console.log(data);


    //const experimentForm = document.querySelector('form')
    //const modelNameIn = document.querySelector('input')
    //console.log('modelNameIn')
    // Assume all went well.
    // You must send back a 200, within 20 seconds
    res.status(200).send(data)

});
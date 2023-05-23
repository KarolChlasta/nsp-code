'use strict';
const path = require('path')
const express = require('express');
//const bodyParser = require('body-parser');
const hbs = require('hbs')
//const util = require('util')

var retOut = 'null'
//const express = require('express');
const app = express();

const viewsPath = path.join(__dirname,'../../templates/views')
const partialsPath = path.join(__dirname,'../../templates/partials')

//console.log(__dirname)
//console.log(path.join(__dirname, '../../public'))

const publicDir = path.join(__dirname, '../../public')

//Setup handlebars engine and view location
app.set('views',viewsPath)
app.set('view engine', 'hbs')
//setup static directory to serve
app.use(express.static(publicDir))


app.use(express.urlencoded({extended: true}));
hbs.registerPartials(partialsPath)


// http://nodejs.org/api.html#_child_processes
//var sys = require('sys');
const { registerHelper } = require('hbs');
var exec = require('child_process').exec;
var child;

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

app.get('/about', (req, res) => {
    res.render('about',{
        title: 'About Project',
        aboutText: 'About page',
        name: 'NSP team'
    })
})


app.get('/runListModels', (req, res) => {

    var cmd = "./src/sh/listModels.sh"
    runCommand(res, cmd, (stdout) => {
            console.log("otrzymany wynik $stdout");
            var objExp = {}
            var array = stdout.toString().split("\n");
            console.log(array)
                for( var i in array) {
                                console.log(array[i]);
                    }
         
            // console.log(util.inspect(objExp, {
            //     depth: null
            //   }));
            res.render('models',{
                title: 'Models page',
                helpText: 'Models page',
                name: 'xxx',
                models: array
            })
           
        })
})


app.get('/addexp', (req, res) => {
    res.render('addexp',{
        title: 'add experiment page',
        text: 'add experiments page',
        name: 'xxx'
    })

})



app.get('/experiments', (req, res) => {
    res.render('experiments',{
        title: 'experiments page',
        helpText: 'experiments page',
        name: 'xxx',
        experiments: [
            "experiments1",
            "experiments2",
            "experiments3",
          ]
    })
})
app.get('/requests', (req, res) => {
    res.render('requests',{
        title: 'requests page',
        text: 'requests page',
        name: 'xxx',
        requests: [
            { symulator: "genessis", modelName: 'RetNet40', simSuffix: 'pawel', simDesc: 'opis experymentu', simTimeStepInSec: 0.00005, simTime: 1, columnDepth: 25, synapticProbability: 0.1, retX: 5, retY: 8, parallelMode: 0, numNodes: 1, modelInput: 0 },
            { symulator: "genessis", modelName: 'RetNet40', simSuffix: 'pawel', simDesc: 'opis experymentu', simTimeStepInSec: 0.00005, simTime: 1, columnDepth: 75, synapticProbability: 0.1, retX: 5, retY: 8, parallelMode: 0, numNodes: 1, modelInput: 0 },
            { symulator: "genessis", modelName: 'RetNet40', simSuffix: 'pawel', simDesc: 'opis experymentu', simTimeStepInSec: 0.00005, simTime: 1, columnDepth: 100, synapticProbability: 0.1, retX: 5, retY: 8, parallelMode: 0, numNodes: 1, modelInput: 0 }
        ]
    })
})


app.get('/runListRequests', (req, res) => {

    var cmd = "./src/sh/listRequests.sh"
    runCommand(res, cmd, (stdout) => {
            console.log("otrzymany wynik $stdout");
            var objExp = {}
            var array = stdout.toString().split("\n");
            console.log(array)
                for( var i in array) {
                                console.log(array[i]);
                    }
         
            // console.log(util.inspect(objExp, {
            //     depth: null
            //   }));
            res.render('requests',{
                title: 'requests page',
                text: 'requests page',
                name: 'xxx',
                models: array
            })
           
        })
})

app.get('/runAddExp', (req, res) => {

    var cmd = "./src/sh/addExp.sh"
    runCommand(res, cmd, (stdout) => {
            res.render('addexp', {
                title: 'experiments added',
                text: stdout,
                name: 'xxx'
            })
    })
})

app.get('/runListExperiments', (req, res) => {

    var cmd = "./src/sh/listSim.sh"
    runCommand(res, cmd, (stdout) => {
            console.log("otrzymany wynik $stdout");
            var objExp = {}
            var array = stdout.toString().split("\n");
            console.log(array)
                for( var i in array) {
                                console.log(array[i]);
                    }
         
            // console.log(util.inspect(objExp, {
            //     depth: null
            //   }));
            res.render('experiments', {
                title: 'experiments',
                text: objExp,
                name: 'xxx',
                experiments:array
            });
        })
})

app.get('/runShowStats', (req, res) => {

    var cmd = "./src/sh/showStat.sh"
    runCommand(res, cmd, (stdout) => {
            console.log("otrzymany wynik $stdout");
            var objExp = {}
            var array = stdout.toString().split("\n");
            console.log(array)
                for( var i in array) {
                                console.log(array[i]);
                    }
         
            // console.log(util.inspect(objExp, {
            //     depth: null
            //   }));
            res.render('statistics', {
                title: 'status of simulation',
                text: 'status of simulation',
                name: 'xxx',
                statistics:array
            })
        })
})
    

app.get('/runLs', (req, res) => {

    var cmd = "dir"
    runCommand(res, cmd, function (stdout){
        res.render('addexp',{
            title: 'experiments added',
            addexpText: stdout,
            name: 'Pawel',
            models: [
                "experiments1",
                "experiments2",
                "experiments3",
              ]
        })
    })
})

app.get('/runPwd', (req, res) => {

    var cmd = "pwd"
    runCommand(res, cmd, function (stdout){
        res.render('addexp',{
            title: 'experiments added',
            addexpText: stdout,
            name: 'xxx'
        })
    });
})




    app.get('/runPing', function (req, res) {
        var cmd = "ping"
        runCommand(res, cmd, function (stdout){
            console.log('callback  runPing');
           res.render('help',{
               title: 'runPing page',
               addexpText: stdout,
               name: 'xxx'
           })
        });
        console.log('get ping');
        })


app.get('/help', (req, res) => {
    res.render('help',{
        title: 'Help page',
        helpText: 'Help page',
        name: 'Pawel'
    })
})
app.get('/help/*', (req, res) => {
    res.render('404',{ 
        title: 'Help page',
        name: 'Pawel',
        notFoundText : 'Help page not found'});
})

app.get('/teams',(req, res)=>{
   console.log(req.query)

   if(!req.query.craft){
    return res.send('provide craft parameters')   
   }
   console.log(req.query.craft)
   const team = getTeam(req.query.craft, (error,data)=>{
       if(error){
            return res.send({error});
       }
       console.log(team)
        return res.send(data
     )

   }) 
   
})

app.get('/users', (req, res) => {
    res.send([
        {
            name: 'Pawel',
            age: 43
        },
        {
            name: 'Pawel2',
            age: 43
        }
    ]);
})

 app.get('*', (req, res) => {
    res.render('404',{ 
        title: 'Page not found',
        name: 'Pawel',
        notFoundText : '404 page'});
 })

app.set('port', (3000))


// Process application/json
app.use(express.json());

// Index route
app.get('/', function (req, res) {
   var cmd = "out"

cmd = "dir"
runCommand(res,cmd, function (stdout){
    res.render('addexp',{
        title: 'experiments added',
        addexpText: stdout,
        name: 'xxx'
    })
});
})

app.get('/dir', function (req, res) {

 const { exec } = require("child_process");
 var cmd = "dir"
  runCommand(res, cmd, function (stdout){
    res.render('addexp',{
        title: 'dir executed',
        addexpText: stdout,
        name: 'xxx'
    })
 });
 })

 app.get('/ls', function (req, res) {
 const { exec } = require("child_process");
 var cmd = "ls"
 runCommand(res, cmd,  function (stdout){
    res.render('addexp',{
        title: 'ls executed',
        addexpText: stdout,
        name: 'xxx'
    })
 });
 })

 

app.post('/webhook/', function (req, res) {
    var data = req.body;
   console.log(data);
    // Assume all went well.
    // You must send back a 200, within 20 seconds
   res.status(200).send(data);
});

app.post('/', (req, res) => {
        var data = req.body;
        console.log('Post server side');
        // Assume all went well.
        // You must send back a 200, within 20 seconds
        res.status(200).send(data)

    });


// Spin up the server
app.listen(app.get('port'), function () {
    console.log('NSP> NSP server running on port', app.get('port'))
})

const runCommand = function(res, command, func)
{
const { exec } = require("child_process");
console.log('runCommand start');
exec(command, (error, stdout, stderr) => {
    if (error) {
        console.log(`error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
    }
    
    console.log(`stdout: ${stdout}`);

    func(stdout)
    //  res.render('addexp',{
    //     title: 'experiments added 2',
    //     addexpText: stdout,
    //     name: 'PAwel'
    // })
    //res.send(stdout)
});

// executes `pwd`
// child = exec("pwd", function (error, stdout, stderr) {
//   sys.print('stdout: ' + stdout);
//   sys.print('stderr: ' + stderr);
//   if (error !== null) {
//     console.log('exec error: ' + error);
//   }
// });


// or more concisely
// var sys = require('sys')
// var exec = require('child_process').exec;
// function puts(error, stdout, stderr) { sys.puts(stdout) }
// exec("ls -la", puts);

}

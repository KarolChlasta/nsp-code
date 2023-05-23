// Load the SDK and UUID
var AWS = require('aws-sdk');
var uuid = require('uuid');

AWS.config.update({region: 'eu-west-1'});

// Create unique bucket name
var bucketName = 'nsp-project';// + uuid.v4();
// Create name for uploaded object key
var keyName = '/requests/requests.txt';

// Create a promise on S3 service object
var bucketPromise = new AWS.S3({apiVersion: '2006-03-01'}).selectObjectContent({Bucket: bucketName}).promise();


//Handle promise fulfilled/rejected states
bucketPromise.then(
  function(data) {
    // Create params for putObject call
    var objectParams = {Bucket: bucketName, Key: keyName, Body: 'Hello World!'};
    // Create object upload promise
    var downloadPromise = new AWS.S3({apiVersion: '2006-03-01', region: 'eu-west-1'}).getObject(objectParams).promise();
    downloadPromise.then(
      function(data) {
        console.log("Successfully downloaded data from " + bucketName + "/" + keyName);
      });
}).catch(
  function(err) {
    console.error(err, err.stack);
});


// Handle promise fulfilled/rejected states
// bucketPromise.then(
//   function(data) {
//     // Create params for putObject call
//     var objectParams = {Bucket: bucketName, Key: keyName, Body: 'Hello World!'};
//     // Create object upload promise
//     var uploadPromise = new AWS.S3({apiVersion: '2006-03-01', region: 'eu-west-1'}).putObject(objectParams).promise();
//     uploadPromise.then(
//       function(data) {
//         console.log("Successfully uploaded data to " + bucketName + "/" + keyName);
//       });
// }).catch(
//   function(err) {
//     console.error(err, err.stack);
// });


// {
//     [
//                 { symulator: "genessis", modelName: 'RetNet40', simSuffix: 'pawel', simDesc: 'opis experymentu', simTimeStepInSec: 0.00005, simTime: 1, columnDepth: 25, synapticProbability: 0.1, retX: 5, retY: 8, parallelMode: 0, numNodes: 1, modelInput: 0 },
//                 { symulator: "genessis", modelName: 'RetNet40', simSuffix: 'pawel', simDesc: 'opis experymentu', simTimeStepInSec: 0.00005, simTime: 1, columnDepth: 75, synapticProbability: 0.1, retX: 5, retY: 8, parallelMode: 0, numNodes: 1, modelInput: 0 },
//                 { symulator: "genessis", modelName: 'RetNet40', simSuffix: 'pawel', simDesc: 'opis experymentu', simTimeStepInSec: 0.00005, simTime: 1, columnDepth: 100, synapticProbability: 0.1, retX: 5, retY: 8, parallelMode: 0, numNodes: 1, modelInput: 0 } 
//     ]
//     }
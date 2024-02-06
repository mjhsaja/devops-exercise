const express = require("express");
const cors = require('cors')
require("@opentelemetry/api");

const app = express();

app.use(cors());

app.all("/", (req, res) => {
   res.json({ method: req.method, message: "Hello OnXP", ...req.body });
});

function cpuIntensiveTask(callback) {
   const primeNumbers = calculatePrimeNumbers(30000);
   callback(`CPU-intensive task completed. Prime numbers: ${primeNumbers.length}`);
}

function calculatePrimeNumbers(limit) {
   const primes = [];
   for (let i = 2; i <= limit; i++) {
       if (isPrime(i)) {
           primes.push(i);
       }
   }
   return primes;
}

function isPrime(num) {
   for (let i = 2, sqrt = Math.sqrt(num); i <= sqrt; i++) {
      if (num % i === 0) {
         return false;
      }
   }
   return num > 1;
}

app.get('/intensive', (req, res) => {
   // Call the CPU-intensive task function
   cpuIntensiveTask((result) => {
      console.log(result);
      res.json({ method: req.method, message: "Running intensive CPU Task. Please wait...", ...req.body });
   });
});

const port = process.env.APP_PORT || "3001";
app.listen(port, function() {
    console.log('server running on port ' + port + '.');
});

/*global WildRydes _config*/

var DemoApp = window.DemoApp || {};


(function demoAppScopeWrapper($) {
    var authToken;
    DemoApp.authToken.then(function setAuthToken(token) {
        if (token) {
            authToken = token;
        } else {
            window.location.href = '/signin.html';
        }
    }).catch(function handleTokenError(error) {
        alert(error);
        window.location.href = '/signin.html';
    });


   function displayUpdate(text) {
        $('#updates').append($('<li>' + text + '</li>'));
    }
    
  //const wsEndpoint = "wss://1vjw7aexd2.execute-api.us-east-1.amazonaws.com/Prod";
  //const restEndpoint = "https://tplbfzbwbf.execute-api.us-east-1.amazonaws.com/Prod";
  const restEndpoint = _config.api.invokeUrlRest;
  const wsEndpoint = _config.api.invokeUrlWebS;
  function init()
  {
      websocket = new WebSocket(wsEndpoint);
      websocket.onopen = function(evt) { onOpen(evt) };
      websocket.onclose = function(evt) { onClose(evt) };
      websocket.onmessage = function(evt) { onMessage(evt) };
      websocket.onerror = function(evt) { onError(evt) };
  }

  function onOpen(evt)
  {
    writeToScreen("Websocket Connection is now open.");
  }

  function getResults(){
    const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    writeToScreen("Fetching Results from Server...");
    let tripMonth = document.getElementById("tripMonth").value;
    let date = new Date(tripMonth);
    date = `${monthNames[date.getMonth()+1]} ${date.getFullYear()}`

    const msg = {
      topicName: "taxi",
      tripMonth: date
    }
    websocket.send(JSON.stringify(msg))
  }

  function onClose(evt)
  {
    writeToScreen("Websocket connection is now closed.");
  }

  function onMessage(evt)
  {
    const data = evt.data
    topicName = data.split('/')[0]
    const statementId = data.split('/')[1]
    if(topicName !== undefined && statementId !== undefined){
      console.log(`${restEndpoint}/?topicName=${topicName}&queryId=${statementId}`);
      const request = new XMLHttpRequest();
      request.open('GET', `${restEndpoint}/?topicName=${topicName}&queryId=${statementId}`);
      request.setRequestHeader("authorization", authToken);
      request.onload = function() {
        const output = JSON.parse(request.response);
        console.log(output);
        if (this.status >= 200 && this.status < 400) {
          const tableHeaders = output.columns.join('</th><th>');

          let rows="";
          for (let record of output.records) {
            rows = rows + '<tr><td>' + record.join('</td><td>')+ '</td></tr>';
          }
          let ele = document.getElementById('outputTable');
          ele.innerHTML = '<tr><th>' + tableHeaders + '</th></tr>' + rows;
        } 
      };
      request.onerror = function() {
        onError(" There was a problem with the request");
      }
      request.send();
      writeToScreen("---");
    }

  }

  function closeConnection(){
    websocket.close(1000, topicName);
  }

  function onError(evt)
  {
    console.log(evt);
    writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
  }

  function writeToScreen(message)
  {
    let ele = document.getElementById('outputText');
    ele.innerHTML = `<p>${message}</p>`;
  }
  
      // Register click handler for #request button
    $(function onDocReady() {
      $('#requestOC').click(handleRequestClick);
		  $('#requestCC').click(handleRequestClick1);
		  $('#requestSubmit').click(handleRequestClick2);

        DemoApp.authToken.then(function updateAuthMessage(token) {
            if (token) {
                $('.authToken').text(token);
            }
        });

    });
    
    function handleRequestClick(event) {
        event.preventDefault();
        init();
    }
	
    function handleRequestClick1(event) {
        event.preventDefault();
        closeConnection();
    }	
    
    function handleRequestClick2(event) {
        event.preventDefault();
        getResults();
    }	
    
        function displayUpdate(text) {
        $('#updates').append($('<li>' + text + '</li>'));
    }
    
}(jQuery));

function sendNotificationToIOS(module, type, value) {
  //call to objective c with project name parameter and type of chart to link to pap screen
  var iframe = document.createElement("IFRAME");
  iframe.setAttribute("src", "ETG?module=\"" + module + "\"&type=\"" + type + "\"&value=\"" + value + "\"");
  iframe.setAttribute("height", "1px");
  iframe.setAttribute("width", "1px");
  document.documentElement.appendChild(iframe);
  iframe.parentNode.removeChild(iframe);
  iframe = null;
}

function validateField(field){
  return field === undefined ||
	field === null ||
	field === 'null' ? 'N/A'
	: field;
}

function validateNumberField(field){
  return field === undefined ||
	field === null ||
	field === 'null' ? 0
	: field;
}

function numberWithCommas(x) {
    if ((typeof x === 'undefined') || x === '(null)%' || x === null || x === undefined) {
        return 'N/A';
    }
    var newNumber = 0;
    x = x.toString();
    var stringNum = x.replace(/,/g,'');
    
    if(stringNum.indexOf('(') !=-1 && stringNum.indexOf(')') !=-1 && stringNum.indexOf('null') === -1){
        stringNum = stringNum.replace(/\(/g,'');
                                      stringNum = stringNum.replace(/\)/g,'');
        newNumber = parseFloat(stringNum).toFixed(2) *-1.00;
    } else {
        newNumber = parseFloat(stringNum).toFixed(2);
    }
    
    //check if the it's not a number
    if(isNaN(newNumber)){
        return 'N/A';
    }
    
    //Seperates the components of the number
    var n = newNumber.toString().split(".");
    //adding commas to the first part
    n[0] = n[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    
    //Combines the two sections
    return n.join(".");
    
}
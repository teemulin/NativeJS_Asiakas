<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaan lis��minen</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table id="lisays">
		<thead>
		<tr>
			<th colspan="3" id="ilmo"></th>
			<th colspan="2" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>
			<tr>
				<th class="vasemmalle">Etunimi</th>
				<th class="vasemmalle">Sukunimi</th>
				<th class="vasemmalle">Puhelin</th>
				<th class="vasemmalle">S�hk�posti</th>
				<th class="vasemmalle"></th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td><input type="text" name="Etunimi" id="Etunimi"></td>
				<td><input type="text" name="Sukunimi" id="Sukunimi"></td>
				<td><input type="text" name="Puhelin" id="Puhelin"></td>
				<td><input type="text" name="Sposti" id="Sposti"></td>
				<td><input type="button" name="nappi" id="tallenna" value="Lis��" onclick="lisaaTiedot()"></td>
			</tr>
		</tbody>
	</table>
</form>
</body>

<script>

document.getElementById("Etunimi").focus();

function tutkiKey(event) {
	if(event.keyCode==13) {
		lisaaTiedot();
	}
}

function lisaaTiedot(){
	var ilmo="";
	if(document.getElementById("Etunimi").value.length<3){
		ilmo="Etunimi ei kelpaa!";		
	}
	else if(document.getElementById("Sukunimi").value.length<3){
		ilmo="Sukunimi ei kelpaa!";		
	}
	else if(document.getElementById("Puhelin").value.length<5){
		ilmo="Puhelinnumero ei kelpaa!";		
	}
	else if(document.getElementById("Puhelin").value*1!=document.getElementById("Puhelin").value){
		ilmo="Puhelin ei ole numeroarvo!";		
	}
	else if(document.getElementById("Sposti").value.length<5){
	ilmo="S�hk�posti ei kelpaa!";		
	}
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function() { document.getElementById("ilmo").innerHTML=""; }, 3000);
		return;
	}
	document.getElementById("Etunimi").value=siivoa(document.getElementById("Etunimi").value);
	document.getElementById("Sukunimi").value=siivoa(document.getElementById("Sukunimi").value);
	document.getElementById("Puhelin").value=siivoa(document.getElementById("Puhelin").value);
	document.getElementById("Sposti").value=siivoa(document.getElementById("Sposti").value);
	
	var formJsonStr=formDataJsonStr(document.getElementById("tiedot"));
	console.log(formJsonStr);
	fetch("asiakkaat",{
		method: 'POST',
		body:formJsonStr
	})
	.then(function (response){
		return response.json()
	})
	.then(function (responseJson) {
		var vastaus = responseJson.response;
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML = "Asiakkaan lis��minen ep�onnistui";
		}
		else if(vastaus==1){
			document.getElementById("ilmo").innerHTML = "Asiakkaan lis��minen onnistui";
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});
	document.getElementById("tiedot").reset();
}
</script>
</html>

//button to valid name, valid week onclick event
document.getElementById("valid_name").onclick = display_week;
document.getElementById("valid_week").onclick = display_sday;
// add function for submit button to delete non validated special day

// var for itérating over day of week
var day_id = 0;
function display_week (){
    //hide button valid name
    document.getElementById("valid_name").style.visibility = "hidden";
    // readonly inputname
    document.getElementById("planning_name").readOnly= true;
    // dispaly section header
    document.getElementById("main_week_header").style.display = "inline";
    // display week controller
    var day_controller = create_day_controller();
    document.getElementById("week_controller").appendChild(day_controller);
    document.getElementById("day_next").onclick = next_day;
    document.getElementById("day_val").onclick = val_day;
    document.getElementById("day_add").onclick = add_cren;
    
    // first day and cren
    next_day();
    add_cren();
} 

// function associé a Day Controller
function next_day(){
    var day = create_day(day_id);
    //day_id++;
    document.getElementById("week_edition").appendChild(day);
    //lock next button
    document.getElementById("day_next").disabled = true;
}

// nombre de creneaux (reset when day are validated)
var cren_id = 1;
function add_cren(){
    var cren = create_creneau(day_id, cren_id);
    cren_id++;
    document.getElementById(''.concat('day_', day_id, '_cren')).appendChild(cren);
}

function val_day(){
    //return the second element (first is the next day in list)
    // use while on nodelist.item() for find id start with sday
    var day = document.getElementById('week_edition').childNodes[1];
    //alert(day.id);
    // insert sday in validated with readonly option on input
    var input = day.getElementsByTagName('input');
    for (let e of input){
	e.readOnly = true;
    }
    document.getElementById("week_validated").appendChild(day);
    // increment day_id
    day_id++;
    // reset nombre de creneaux
    cren_id = 1;
    // test if Sunday is validated
    if ( day_id < 7 ){
	next_day();
	add_cren();
	document.getElementById("week_edition").focus({preventScroll:false});
    }else{
	//yes => unload week controller/edition, display week_validation 
	document.getElementById("week_controller").style.display = "none";
	document.getElementById("week_edition").style.display = "none";
	document.getElementById("valid_week").style.display = "inline";
    }

}

// var for special day 
var sday_id = 1;
// Display specail Day header
function display_sday(){

    // add sDay contoller
    var sday_controller = create_sday_controller();
    document.getElementById("sday_controller").appendChild(sday_controller);
    // actions(Events) for special day controller [LIST]
    document.getElementById("sday_add").onclick = add_sday;
    document.getElementById("sday_val").onclick = val_sday;
    document.getElementById("sday_cren").onclick = cren_sday;
    
    // remove week button 
    document.getElementById("valid_week").style.visibility = "hidden";
    // add sbay validation button and event (submit button)
    document.getElementById("valid_sday").style.display = "inline";
    // display header for Special day
    document.getElementById("main_sday_header").style.display = "inline";
}


//function associé a sDay Controller
function add_sday(){
    var sday = create_sday(sday_id);
    
    document.getElementById("sday_edition").appendChild(sday);
    //lock button
    document.getElementById("sday_add").disabled = true;
    
}
// nb cren by special day (reset when special day is validated)
var sday_cren_id = 1;
function cren_sday(){
    var cren = create_creneau_sday(sday_id, sday_cren_id);
    sday_cren_id++;
    document.getElementById(''.concat('sday_', sday_id, '_cren')).appendChild(cren);
}
function val_sday(){
    //return the second element (first is h3 -> second is the first specail day in list)
    // use while on nodelist.item() for find id start with sday
    var sday = document.getElementById('sday_edition').childNodes[3];
    //alert(sday.id);
    // insert sday in validated with readonly option on input
    var input = sday.getElementsByTagName('input');
    for (let e of input){
	e.readOnly = true;
    }
    document.getElementById("sday_validated").appendChild(sday);
    // increment sday_id after validated
    sday_id ++;
    //unlock sday_add button
    document.getElementById("sday_add").disabled = false;

}


// create day of week
function create_day(day_id){
    //var days_id = [0, 1, 2, 3, 4, 5, 6];
    var day_name = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];
    
    // create main day div
    var div_day = document.createElement('div');
    div_day.setAttribute('id', ''.concat("day_", day_id));
    // add header add inside div with id day_[0..7]_header
    var header = document.createElement('h3');
    header.textContent = day_name[day_id];  
    // create div for creneaux host id day_[0..7]_cren
    var div_cren = document.createElement('div');
    div_cren.setAttribute('id', ''.concat("day_", day_id, "_cren"));
    div_cren.setAttribute('class', 'row');

    div_day.appendChild(header);
    div_day.appendChild(div_cren);

    return div_day;    
}

// create creneau for day of week
function create_creneau(day_id, cren_id){
    
    //label 0 to 4
    //var input_id = [0, 1, 2, 3, 4];
    var input_id = ["nb", "start_date", "start_time", "end_date", "end_time"];
    var input_label = ["Nombre de Personne", "Start Date", "Start Time", "End Time", "End Time"];
    
    var div_cren = document.createElement('div');
    div_cren.setAttribute('id', ''.concat("day_",day_id, "_", cren_id));
    div_cren.setAttribute('class', 'col-3');

    // for all inputs
    for (let i = 0; i < 5; i++) {
	var div = document.createElement('div');
	div.setAttribute('class', 'row');
	// create label balise
	var label = document.createElement('label');
	label.setAttribute('for', ''.concat("day_", day_id, "_", cren_id, "_", input_id[i]));
	label.textContent = input_label[i];
	//create input balise
	var input = document.createElement('input');
	input.setAttribute('id', ''.concat("day_", day_id, "_", cren_id, "_", input_id[i]));
	input.setAttribute('name', ''.concat("day_", day_id, "_", cren_id, "_", input_id[i]));
	input.setAttribute('class', 'form-control');
	input.setAttribute('type', 'text');
	
	//insert element inside each other
	div.appendChild(label);
	div.appendChild(input);
	div_cren.appendChild(div);
    }
    return div_cren;
}

// create Special Day Controller
function create_day_controller (){
    var div_day_controller = document.createElement('div');
    div_day_controller.setAttribute('id', 'day_header_control');
    div_day_controller.setAttribute('class', 'row');

    var div_next = document.createElement('div');
    div_next.setAttribute('class', 'col');
    var button = document.createElement('button');
    button.setAttribute('id', 'day_next');
    button.setAttribute('type', 'button');
    button.setAttribute('class', 'btn-success');
    button.textContent = "Next Day";

    div_next.appendChild(button);
    div_day_controller.appendChild(div_next);

    var div_add = document.createElement('div');
    div_add.setAttribute('class', 'col');
    var button = document.createElement('button');
    button.setAttribute('id', 'day_add');
    button.setAttribute('type', 'button');
    button.setAttribute('class', 'btn-success');
    button.textContent = "Add Creneau";

    div_add.appendChild(button);
    div_day_controller.appendChild(div_add);

    var div_val = document.createElement('div');
    div_val.setAttribute('class', 'col');
    var button = document.createElement('button');
    button.setAttribute('id', 'day_val');
    button.setAttribute('type', 'button');
    button.setAttribute('class', 'btn-success');
    button.textContent = "Val Day";

    div_val.appendChild(button);
    div_day_controller.appendChild(div_val);

    return div_day_controller;
    
}

// defined creneau_header
function create_creneau_header(sday_id){
    // return div Element with creneaux header input

    //label 0 to 3
    //var input_id = [0, 1, 2, 3];
    var input_id = ["type", "start_date", "end_date"];
    var input_label = ["Type Special Day", "Start Date", "End Date"];
    
    var div_head = document.createElement('div');
    div_head.setAttribute('id', ''.concat('sday_head_', sday_id));
    div_head.setAttribute('class', 'row');
    var title = document.createElement('h3');
    title.textContent = ''.concat('Special Day N°', sday_id);
    div_head.appendChild(title);

    for (let i = 0; i < input_id.length; i++){
	var div = document.createElement('div');
	div.setAttribute('class', 'col');
	
	var label = document.createElement('label');
	label.setAttribute('for', ''.concat('sday_', sday_id, '_', input_id[i]));
	label.textContent = input_label[i];
	
	var input = document.createElement('input');
	input.setAttribute('id', ''.concat("sday_", sday_id, "_", input_id[i]));
	input.setAttribute('name', ''.concat("sday_", sday_id, "_", input_id[i]));
	input.setAttribute('class', 'form-control');
	input.setAttribute('type', 'text');

	div.appendChild(label);
	div.appendChild(input);
	div_head.appendChild(div);
    }
    return div_head;
    
}
// defined block creneau
function create_creneau_sday(sday_id, cren_id) {
    //return div Element with creneaux configuration
    
    //label 0 to 4
    //var input_id = [0, 1, 2, 3, 4];
    var input_id = ["rule", "nb", "start_date", "start_time", "end_date", "end_time"];
    var input_label = ["Rule", "Nombre de Personne", "Start Date", "Start Time", "End Time", "End Time"];
    
    //Div Day
    var div_day = document.createElement('div');
    div_day.setAttribute('id', ''.concat("sday_", sday_id,'_input'));
    div_day.setAttribute('class', 'col-3');
    // for all inputs
    for (let i = 0; i < input_id.length; i++) {
	var div = document.createElement('div');
	div.setAttribute('class', 'row');
	// create label balise
	var label = document.createElement('label');
	label.setAttribute('for', ''.concat("sday_", sday_id, "_",cren_id, "_", input_id[i]));
	label.textContent = input_label[i];
	//create input balise
	var input = document.createElement('input');
	input.setAttribute('id', ''.concat("sday_", sday_id, "_",cren_id, "_", input_id[i]));
	input.setAttribute('name', ''.concat("sday_", sday_id, "_",cren_id, "_", input_id[i]));
	input.setAttribute('class', 'form-control');
	input.setAttribute('type', 'text');
	
	//insert element inside each other
	div.appendChild(label);
	div.appendChild(input);
	div_day.appendChild(div);
    }
    return div_day;
}
// defined special block day
function create_sday (sday_id) {
    var div_sday = document.createElement('div');
    div_sday.setAttribute('id', ''.concat('sday_', sday_id));
    div_sday.setAttribute('class', '');

    var div_head = create_creneau_header(sday_id);
    var div_cren = document.createElement('div');
    div_cren.setAttribute('id', ''.concat('sday_', sday_id, '_cren'));
    div_cren.setAttribute('class', 'row');
    
    div_sday.appendChild(div_head);
    div_sday.appendChild(div_cren);
    //div_sday.appendChild(document.createElement('hr'));

    return div_sday;
}
// create Special Day Controller
function create_sday_controller (){
    var div_sday_header = document.createElement('div');
    div_sday_header.setAttribute('id', 'sday_header_control');
    div_sday_header.setAttribute('class', 'row');

    var div_add = document.createElement('div');
    div_add.setAttribute('class', 'col');
    var button = document.createElement('button');
    button.setAttribute('id', 'sday_add');
    button.setAttribute('type', 'button');
    button.setAttribute('class', 'btn-success');
    button.textContent = "Add Day";

    div_add.appendChild(button);
    div_sday_header.appendChild(div_add);

    var div_cren = document.createElement('div');
    div_cren.setAttribute('class', 'col');
    var button = document.createElement('button');
    button.setAttribute('id', 'sday_cren');
    button.setAttribute('type', 'button');
    button.setAttribute('class', 'btn-success');
    button.textContent = "Add Creneau";

    div_cren.appendChild(button);
    div_sday_header.appendChild(div_cren);

    var div_val = document.createElement('div');
    div_val.setAttribute('class', 'col');
    var button = document.createElement('button');
    button.setAttribute('id', 'sday_val');
    button.setAttribute('type', 'button');
    button.setAttribute('class', 'btn-success');
    button.textContent = "Val Day";

    div_val.appendChild(button);
    div_sday_header.appendChild(div_val);

    return div_sday_header;
    
}


// ***deprecated*** //

// set input for week edition in readonly mode
function readonly_week (){
    var main_div = document.getElementById("main_week");
    var input = main_div.getElementsByTagName("input");
    //alert(input);
    for (let e of input){
	e.readOnly = true;
    }    
}

function set_week () {    
    //set up variable
    //day 0 to 6
    //var days_id = [0, 1, 2, 3, 4, 5, 6];
    var day_name = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"];
    //label 0 to 4
    //var input_id = [0, 1, 2, 3, 4];
    var input_id = ["nb", "start_date", "start_time", "end_date", "end_time"];
    var input_label = ["Nombre de Personne", "Start Date", "Start Time", "End Time", "End Time"];
    

    //start creation of a week block
    //Div Week
    var div_week= document.createElement('div');
    div_week.setAttribute('id', 'input_week');
    div_week.setAttribute('class', 'row');
    // for all week days
    for (let day = 0; day < 7; day++){
	//Div Day
	var div_day = document.createElement('div');
	div_day.setAttribute('id', ''.concat("day_",day));
	div_day.setAttribute('class', 'col-3');
	//header
	var header = document.createElement('h3');
	header.textContent = day_name[day];
	div_day.appendChild(header);
	// for all inputs
	for (let i = 0; i < 5; i++) {
	    var div = document.createElement('div');
	    div.setAttribute('class', 'row');
	    // create label balise
	    var label = document.createElement('label');
	    label.setAttribute('for', ''.concat("day_", day, "_", input_id[i]));
	    label.textContent = input_label[i];
	    //create input balise
	    var input = document.createElement('input');
	    input.setAttribute('id', ''.concat("day_", day, "_", input_id[i]));
	    input.setAttribute('name', ''.concat("day_", day, "_", input_id[i]));
	    input.setAttribute('class', 'form-control');
	    input.setAttribute('type', 'text');
	    
	    //insert element inside each other
	    div.appendChild(label);
	    div.appendChild(input);
	    div_day.appendChild(div);
	}
	div_week.appendChild(div_day);
	//div_week.appendChild(document.createElement('hr'));
    }
    
    //add to docuemnt
    document.getElementById("main_week").appendChild(div_week);
}


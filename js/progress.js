'use strict';

var curr_tab, prev_tab;
var isfirst  = true;
var est      = 0;       // vergangene Wartezeit
var interval = 10000;   // Wartezeit zwischen den Polls in ms
var maxwait  = 7200000;  // maximale Wartezeit in ms
var finished = null;
var messages = {};
var formData = {};

var validateForm = function(divid) {
    if($(divid+' form').length > 0) {
        $(divid+' form')[0].classList.add('was-validated');
        if(!$(divid+' form')[0].checkValidity()) {
            return false;
        }
    }
    return true;
};

var poll = function() {
    //console.log('poll, est ' + est);
    $.ajax({
        type    : "GET",
        url     : $("body").data("base-url") + "?checkprogress",
        dataType: "json",
        success : function(data, status) {
            if(data.running == false)
            { 
                finished = true;
                clearInterval(checkInstallJob);
                if(data.success == true)
                {
                    // success
                    $("div#installation_in_progress").hide();
                    $("div#installation_error").hide();
                    $("div#installation_warning").hide();
                    $("div#installation_progress").hide();
                    $("div#installation_success").show();
                } else {
                    // fail
                    $("div#installation_in_progress").hide();
                    $("div#installation_error").append(data.message).show();
                }
            } else {
                // poll
                //if(!(data.message in messages)) {
                    data.message = data.message.replace(/(?:\r\n|\r|\n)/g, '<br>');
                    //data.message = data.message.replace("\n","<br />");
                    $("div#installation_progress").find("span#progress").html(data.message);
                    messages[data.message] = 1;
                //}
            }
        },
        error   : function(data, status) {
            $("div#installation_in_progress").hide();
            $("div#installation_error").append(status).show();
            est = maxwait;
        }
    });
    est = est + interval;
    if(est > maxwait) {
        $("div#installation_in_progress").hide();
        $("div#installation_warning").show();
        clearInterval(checkInstallJob);
        finished = true;
    } else {
        var checkInstallJob = setInterval(function() {
            if( typeof finished != "boolean" ) {
                poll();
            }
            else {
                clearInterval(checkInstallJob);
            }
        }, interval);
    }
}

// handle tab change
$('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
    curr_tab = $(e.target).attr('href');
    prev_tab = $(e.relatedTarget).attr('href');
    if(typeof prev_tab != 'undefined') {
        if(!validateForm('div'+prev_tab)) {
            e.preventDefault();
            $(e.relatedTarget).trigger('click');
        } else {
            var formname = $(e.relatedTarget).attr('href').replace("#","");
            //console.log(formname);
            var fields = $("form#"+formname).serializeArray();
//console.log(fields);
            $.each(fields,function(i,field) {
                formData[field.name] = field.value;
            });
//console.log(formData);
            if($('div'+curr_tab).find('table#summarytable').length) {
                var tbody = $('div'+curr_tab).find('table#summarytable tbody');
                $.each(formData,function(field, value) {
                    if(field!="proceed" && field!="admin_password_repeat" && field!="modlist[]") {
                        tbody.find('span#'+field).html(value);
                    }
                });
            }
            if($('div'+curr_tab).find('div#installation_in_progress').length) {
formData["install"] = 1;
                formData["run_composer"] = $("form#composer input#run_composer").val();
                // reset from previous errors
                est = 0; // reset timer
                finished = null;
                isfirst = true;
                $("div#installation_error").hide();
                $("div#installation_success").hide();
                $("div#installation_warning").hide();
                $("div#installation_progress").hide();
                $("span#progress").text('');
                $("div#installation_in_progress").show();
                $.ajax({
                    type    : "POST",
                    url     : $("body").data("base-url") + "?install&proceed",
                    dataType: "json",
                    data    : formData,
                    success : function(data, status) {
                        if(data.success == false) {
                            $("div#installation_in_progress").hide();
                            $("div#installation_error").text(data.message).show();
                        } else {
                            // poll
                            $("div#installation_progress").show();
                            poll();
                        }
                    },
                    error   : function(data, status) {
                        $("div#installation_in_progress").hide();
                        $("div#installation_error").text(status).show();
                    }
                });
            }
            $(e.relatedTarget).find('span.progress-marker').removeClass('bg-warning').addClass('bg-success');
            $(e.relatedTarget).find('span.progress-text').removeClass('text-warning').addClass('text-muted');
            $(e.relatedTarget).parent().addClass('is-complete');
            $(e.target).find('span.progress-marker').addClass('bg-warning');
            $(e.target).find('span.progress-text').removeClass('text-muted').addClass('text-warning');
            $(e.target).parent().addClass('is-active');
        }
    }
});
// open first tab
$('a[data-toggle="tab"]:first').trigger('click');
// next button
$('button#next').unbind('click').on('click',function(e) {

console.log($('.nav-tabs a.active').parent().next('li').find('a:first'));

    $('.nav-tabs a.active').parent().next('li').find('a:first').trigger('click');
});


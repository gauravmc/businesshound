// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(function(){
	$('a.edit, a.trash').tooltip({placement: "top"});
	$('a#add-item').tooltip({placement: "left"});
	
	// activeLinks plugin takes care of appropriately adding 'active' class to links inside navbars and sidebars
	jQuery.fn.activeLinks = function() {
		link_tag = this.find("a[href='" + window.location.pathname + "']");
		link_tag.parent('li').addClass("active");
		
		if(!this.hasClass('black'))
		{
			if(this.find("a i").length) { this.find("a i").removeClass("icon-white");}
			if(link_tag.find("i").length) { link_tag.find("i").addClass("icon-white"); }
		}
	};
	
	$('#navigation').activeLinks();
	$('#admin-sidebar').activeLinks();
	$('#store-sidebar').activeLinks();
});

function formatDate(date) {
  day = ('0' + date.getDate()).slice(-2)
  month = ('0' + (date.getMonth()+1)).slice(-2)
  year = date.getFullYear()
	return day + '-' + month + '-' + year
}

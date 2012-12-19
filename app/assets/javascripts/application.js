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
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function(){
	$('a.edit, a.trash').tooltip({placement: "top"});
	$('a#add-item').tooltip({placement: "left"});
	
	// activeLinks plugin takes care of appropriately adding 'active' class to links inside navbars and sidebars
	jQuery.fn.activeLinks = function() {
		var url = window.location.href;
		url = url.substr(url.indexOf("/", 10));
		link_tag = this.find("a[href='" + url + "']");
		link_tag.parent('li').addClass("active");
		
		if(!this.hasClass('black'))
		{
			if(this.find("a i").length) { this.find("a i").removeClass("icon-white");}
			if(link_tag.find("i").length) { link_tag.find("i").addClass("icon-white"); }
		}
	};
	
	$('#navigation').activeLinks();
	$('#admin-sidebar').activeLinks();
});
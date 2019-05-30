// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

// bootstrap-sprocketsは、jqueryの後に追加しないとだめ。
//= require jquery
//= require rails-ujs
//= require activestorage
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .



// 発火用
$(document).on('turbolinks:load',function() {



	/*******************************
	* google 検索ボタン
	********************************/

	var google = function( btn, target ) {
			$(btn).click(function(){
				var word = $(target).val();
				window.open('http://www.google.com/search?q=中国語%20'+word);
			});
	}

//--------------- passage_new -------------------
	$("#passage_new_title_google").click(function(){
		var word = $('#passage_title').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#passage_new_ch_google").click(function(){
		var word = $('#passage_ch').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#passage_new_ja_google").click(function(){
		var word = $('#passage_ja').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	//単語の検索ボタンは繰り返しの担保のため、HTML内に書いた

//--------------- passage_new -------------------


//--------------- p_word_pinedit -------------------
	$("#p_word_pin_edit_ch").click(function(){
		var word = $('#p_word_pinedit').text();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});



/*******************************
* psr新規作成フッターナビ
********************************/
	$(function() {
	  $('.toggle').click(function() {
	    $('.nav-item').toggleClass('slide-out');
	    $('.nav-item-text').toggleClass('slide-out-for-text');
	  });
	});

  // feedbackをふわっと消す
    $(function(){
      setTimeout("$('.feedback').fadeOut('slow')", 2800)
    })


});
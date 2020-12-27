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


//--------------- p_word_edit -------------------
	$("#p_word_edit_ch").click(function(){
		var word = $('#p_word_ch').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#p_word_edit_ja").click(function(){
		var word = $('#p_word_ja').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});

//--------------- p_word_pinedit -------------------
	$("#p_word_pin_edit_ch").click(function(){
		var word = $('#p_word_pinedit').text();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});


//--------------- paper_edit -------------------
	$("#paper_new_title_google").click(function(){
		var word = $('#paper_name').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});

//--------------- sentence_new -------------------
	$("#sentence_new_ch_google").click(function(){
		var word = $('#sentence_ch').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#sentence_new_ja_google").click(function(){
		var word = $('#sentence_ja').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});

//--------------- sentence_edit -------------------
	$("#sentence_edit_ch_google").click(function(){
		var word = $('#sentence_ch').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#sentence_edit_ja_google").click(function(){
		var word = $('#sentence_ja').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});


//--------------- ring_edit -------------------
	$("#ring_new_title_google").click(function(){
		var word = $('#ring_name').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#r_word_edit_ja").click(function(){
		var word = $('#r_word_ja').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});

//--------------- r_word_edit -------------------
	$("#r_word_edit_ch").click(function(){
		var word = $('#r_word_ch').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});
	$("#r_word_edit_ja").click(function(){
		var word = $('#r_word_ja').val();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});

//--------------- r_word_pinedit -------------------
	$("#r_word_pin_edit_ch").click(function(){
		var word = $('#r_word_pinedit').text();
		window.open('http://www.google.com/search?q=中国語%20'+word);
	});

//--------------- feedbackをふわっと消す -------------------
  $(function(){
    setTimeout("$('.feedback').fadeOut('slow')", 2800);
  })

//--------------- ダブルクリック防止 -------------------
	$(".prevent_double_click").click(function(){
		$('.prevent_double_click').addClass('click_disable');
	});



	/*******************************
	* モーダル
	********************************/
  $("#open").on("click", function(e) {
      e.preventDefault();
      $("#passage-ja-modal").addClass("active");

      $("#passage-ja-modal-close").on("click", function() {
          $("#passage-ja-modal").removeClass("active");
          return false;
      });
  });


  $("#passage-tutorial-modal-close").on("click", function() {
      $("#passage-tutorial-modal").fadeOut('slow');
      return false;
  });

  //-----サンプル単語帳に出てくるチュートリアルモーダル------
  $(document).on('turbolinks:load', function() {
      $('#tutorial-rings').modal('show');
  });
  $(window).on('load',function(){
      $('#tutorial-rings').modal('show');
  });

	/*******************************
	* explore form
	********************************/
  $('#explore-form-show').click(function () {
      $('#explore-form-hidden').show('slow');
  });


	/*******************************
	* 円グラフ
	********************************/
  $(function(){
    var $ppc = $('.progress-pie-chart'),
      percent = parseInt($ppc.data('percent')),
      deg = 360*percent/100;
    if (percent > 50) {
      $ppc.addClass('gt-50');
    }
    $('.ppc-progress-fill').css('transform','rotate('+ deg +'deg)');
    $('.ppc-percents span').html(percent+'%');
  });



  /*******************************
  * home お役立ち記事のランダム並び替え
  ********************************/
  $(function() {
    var box = [];
    $('ul#home-article-cards li').each(function() {
        box.push($(this).html());
    });
    box.sort(function() {
        return Math.random() - Math.random();
    });
    $('ul#home-article-cards li').empty();

    var i = 0;
    $('ul#home-article-cards li').each(function() {
        $(this).append(box[i]);
        i++;
    });
  });

  $(function() {
    var box = [];
    $('ul#home-article-cards-tablet li').each(function() {
        box.push($(this).html());
    });
    box.sort(function() {
        return Math.random() - Math.random();
    });
    $('ul#home-article-cards-tablet li').empty();

    var i = 0;
    $('ul#home-article-cards-tablet li').each(function() {
        $(this).append(box[i]);
        i++;
    });
  });

});


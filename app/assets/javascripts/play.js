(function($) {

  window.onload = function(){
    console.log('play!');
    var start_button = document.querySelector('#game-start-button');
    // debugger;
    start_button.onclick = function(e) {
      console.log('clicked');
      start_game(start_button);
    };
    // debugger;
  }

  function start_game(start_button) {
    var gamearea = document.querySelector('#game-area');
    showDom(gamearea);
    hideDom(start_button);
    fetchText(start_typing);
  };

  function start_typing(collection_json) {
    var problem_area = document.querySelector('#game-problem-text');
    var texts = collection_json.texts;
    var len = texts.length;

    function updateText(i) {
      if (i > len - 1) {
        end_game();
      } else {
        var text = texts[i];
        problem_area.innerHTML = '';
        problem_area.appendChild(createTextDom(text));
        var answerText = document.querySelector('#game-text-answer').textContent;
        var user_input = document.querySelector('#game-user-input');
        user_input.oninput = function() {
          if (document.querySelector('#game-user-input').value == answerText) {
            user_input.oninput = undefined;
            document.querySelector('#game-user-input').value = '';
            updateText(i + 1)
          }
        };
      }
    }
    updateText(0);
  }


  function createTextDom(textJson) {
    var textDom = document.createElement('div');
    var title = document.createElement('h3');
    title.textContent = textJson.title;
    var body = document.createElement('p');
    body.textContent = textJson.body;
    body.setAttribute('id', 'game-text-answer')
    textDom.appendChild(title);
    textDom.appendChild(body);
    return textDom;
  }

  function fetchText(cb) {
    var play_url = location.href;
    var target_url = play_url.slice(0, -5); // remove trailing `/play`
    target_url += '.json'
    $.getJSON(target_url, cb);
  }

  function end_game() {
    var resultarea = document.querySelector('#game-result-area');
    var start_button = document.querySelector('#game-start-button')
    var gamearea = document.querySelector('#game-area');
    showDom(start_button);
    showDom(resultarea);
    hideDom(gamearea);
  }

  function showDom(dom) {
    dom.style.display = 'block';
  }

  function hideDom(dom) {
    dom.style.display = 'none';
  }

})(jQuery);

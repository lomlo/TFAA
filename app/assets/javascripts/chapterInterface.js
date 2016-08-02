// 
// function makeChoice(event) {
//   event.preventDefault();
//   var href = event.path[0].href
//   var adventure_id = href.match(/\/\d/g)[0].match(/\d/)[0]
//   var current_chapter_id = document.URL.match(/\/\d/g)[1].match(/\d/)[0]
//   var next_chapter_id = href.match(/\/\d/g)[1].match(/\d/)[0]
//   console.log(adventure_id, current_chapter_id, next_chapter_id);
//   $.ajax({
//     type: 'GET',
//     url: '/adventures/' + adventure_id + '/chapters/' + next_chapter_id,
//     dataType: 'json',
//     contentType: 'application/json',
//     data: JSON.stringify({
//       current_chapter_id: current_chapter_id,
//       next_chapter_id: next_chapter_id,
//       adventure_id: adventure_id
//     })
//   });
// }

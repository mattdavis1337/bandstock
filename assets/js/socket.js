// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

// Now that you are connected, you can join channels with a topic:


//document.addEventListener("DOMContentLoaded", function(event) {
window.onload = function() {
  console.log("Loading Sockets...")
  let channel = socket.channel("board:26", {}); //TODOMFD: THis is a hard coded Database ID, needs changed!

  channel.join()
    .receive("ok", resp => {
      console.log("...Sockets Loaded", resp);
      var event = new Event("initBoard");
      event.board = resp.board.data;
      window.dispatchEvent(event);
    })
    .receive("error", resp => { console.log("Unable to join", resp) });

  channel.on("board_output", payload => {

    if(payload.type == "swap"){

      console.log(payload);
      var event = new Event("swapTiles");
      var tile1 = {x: payload.body.tile1.x, y:payload.body.tile1.y}
      var tile2 = {x: payload.body.tile2.x, y:payload.body.tile2.y}
      event.tile1 = tile1;
      event.tile2 = tile2;
      window.dispatchEvent(event);
    }
  })

  document.addEventListener( 'keydown', function(event) {
    switch( event.keyCode ) {
      case 73: //I
        var event = new Event("keyDownI");
        window.dispatchEvent(event);
        //channel.push("board_input", {body: "board_input body"});
        break;
      case 85: //U
        var event = new Event("keyDownU");
        window.dispatchEvent(event);
        break;
    }
  }, false);


  document.addEventListener( 'doJoinChannel', function(event) {

    console.log("doJoinChannel")
    console.log(event)

    let channel = socket.channel(event.channelID, {});
    channel.join()
      .receive("ok", resp => {
        console.log("doJoinChannel response");
        console.log(resp.artist.data);
        var event = new Event("drawArtist");
        event.artist = resp.artist.data;
        window.dispatchEvent(event);
      })
      .receive("error", resp => { console.log("Unable to join " + event.channelID, resp) });

    channel.on("channel_output", payload => {
      if(payload.type == "place_tile"){
        console.log(payload);
        var event = new Event("placeTile");
        // var tile1 = {x: payload.body.tile1.x, y:payload.body.tile1.y}
        // var tile2 = {x: payload.body.tile2.x, y:payload.body.tile2.y}
        // event.tile1 = tile1;
        // event.tile2 = tile2;
        window.dispatchEvent(event);
      }
    })
  });
};

export default socket

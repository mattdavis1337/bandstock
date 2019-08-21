# Bandstock

To start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`




# Notes
bandstock_web/router.ex has the route entries
mix phx.routes shows all live routes derived from router.ex

Current focus is on the route:
artist_path  GET     /artists/:id       BandstockWeb.ArtistController :show

The view show.html.eex is a 3.js renderer viewport the size of the whole screen:
// renderer.setViewport( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );

This viewport will load objects from the server relevant to one particular artists
and display them on the screen.

We are aiming to have the Artist Logo, Social Media Links and 3 Bandstock Cards appear on the first iteration.

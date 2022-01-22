# Create a Spotify Playlist with Terraform

Used Spotify API, Docker Desktop, and Terraform to create a playlist

![tf-spotify](https://user-images.githubusercontent.com/10605985/150623423-30bf18a6-e9ba-418e-b5c3-02e6741b68ad.png)

## Steps
1. Launch Docker Desktop and start server, create project folder, start terminal 
2. Create a Spotify dev app
3. Config and start authorization proxy server so TF can interact with Spotify (TF > spotify_auth_proxy > Spotify API to publish playlist)
4. From terminal, set URI as env var so server can serve SPotify access tokens on port 27228
5. In new file, pase client id and client secret from Spotify app page
6. In terminal - `docker run --rm -it -p 27228:27228 --env-file ./.env ghcr.io/conradludgate/spotify-auth-proxy`
7. Clone `git clone https://github.com/hashicorp/learn-terraform-spotify.git` and change into dir
8. Edit main.tf, Add api key, Install/init Spotify provider, tf apply to create playlist

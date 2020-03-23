Hi
This docker image is for arm arhitecture
https://matchboxdorry.gitbooks.io/matchboxblog/content/blogs/build_and_run_arm_images.html
docker build -t . name-tag


# alternative
https://mirailabs.io/blog/multiarch-docker-with-buildx/
docker run --rm --privileged multiarch/qemu-user-static --reset

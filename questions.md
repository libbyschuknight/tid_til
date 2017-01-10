# Questions

- What is 12 factor rails?


#### DevOps

- What is a health check in relation to devops?

- [What is Docker?](https://www.docker.com/what-docker)

>Containers and virtual machines have similar resource isolation and allocation benefits -- but a different architectural approach allows containers to be more portable and efficient.
>VIRTUAL MACHINES
>Virtual machines include the application, the necessary binaries and libraries, and an entire guest operating system -- all of which can amount to tens of GBs.
>CONTAINERS
>Containers include the application and all of its dependencies --but share the kernel with other containers, running as isolated processes in user space on the host operating system. Docker containers are not tied to any specific infrastructure: they run on any computer, on any infrastructure, and in any cloud.
https://www.docker.com/what-docker

Talk by @nigelramsay from @abletech, at Wellrailed meetup
[Adding Docker to a  Rails App](https://docs.google.com/presentation/d/1wYr5JW30CG6cUHOVRB9WsU0wtD8WJMzPdD-ryyquNJw/edit#slide=id.g197f8abe5b_0_1204)


- What is an image, container in relation to devops?

- Workers...

- HTTP requests...

- What is distributed logging?

- REST...


####
- What is white labelling?

- Lambda?

### CSS
How does this work?

```css
p#some_id_tag {
  css...
}
```
Trying to hit the p tag within a id tag,
```html
<p id="some_id_tag">We'll be in touch for more details about this.</p>
```
Thought this would work, but it didn't:
```css
#some_id_tag p {
  css...
}
```

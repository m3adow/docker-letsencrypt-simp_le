### Alpine Linux simp_le Docker container

This is a containerfile for the **"simp_le"** Let's encrypt implementation by kuba (https://github.com/kuba/simp_le). It's running on Alpine Linux and is only around 90MB in size.
It was inspired by `katta/sim_le` but has a couple of improvements.

Certs are saved in `/certs` so you should mount a persistent volume there.

#### Simple run

If you only want to get some certificates, simply run the container like this:

	docker run -ti -p 80:80 -v /etc/nginx/certs:/certs \
	m3adow/letsencrypt-simp_le -f account_key.json  \
	-f chain.pem -f cert.pem -f key.pem --email a@example.org \
    -d adminswerk.de -d test.adminswerk.de

#### Repo Refresh

**simp_le** is refreshed from the repos master branch at container start. This normally takes not more than one second and ensures it's always up to date. If you want to disable this functionality, start the container with the environment variable `SKIP_REFRESH` set. It doesn't matter which value it contains as long as it's not null.

	docker run -ti -p 80:80 -v /etc/nginx/certs:/certs -e "SKIP_REFRESH=1" \
		m3adow/letsencrypt-simp_le -f account_key.json  -f chain.pem \
		-f cert.pem -f key.pem --email a@example.org -d adminswerk.de

#### Entrypoint Override

By default the container starts with an entrypoint-script which passes all arguments you start the container with to `simp_le.py`. If you want to start another application, e.g. for debugging or to build something ontop the container, you have to set the environment variable `OVERRIDE`. Identical to `SKIP_REFRESH`, it only needs to be not null, the value doesn't matter. `OVERRIDE` implies `SKIP_REFRESH` (but not the other way around), so no need to define both envs.

	docker run -ti -p 80:80 -v /etc/nginx/certs:/certs -e "OVERRIDE=1" \
		m3adow/letsencrypt-simp_le sh

# Vientus front end in Elm

Redesigning [Vientus](http://www.vient.us) front end in Elm to learn how to use Elm
in Production.

[App in Production](http://www.vient.us)

## Things to learn:
- Production App Code structure
- Use of Elm-css
- Communication of Elm with a REST API
- Interop between Elm & Js
- I18N

### Install:
```
npm install
```

If you haven't done so yet, install Elm globally:
```
npm install -g elm
```

Install Elm's dependencies:
```
elm package install
```

### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`
* To publish new changes to amazon run:
```
aws s3 sync dist s3://www.vient.us
```

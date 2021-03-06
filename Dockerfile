PaxHeader/README.md                                                                                 000644  777777  777777  00000000275 13461562417 020637  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556538639.878972879
30 ctime=1556538639.879485507
30 atime=1556538807.272709714
23 SCHILY.dev=16777220
22 SCHILY.ino=3943253
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   README.md                                                                                           000644  �   UU��   ]�K(00000001013 13461562417 017301  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         # Introduction
  
This is a template for go-micro services deployment. 

# Getting started

First thing to do is clone this repo with your project path:

## What's contained in this project

- main.go - is the main definition of the service, handler and client

## Dependencies

- [ Golang ](https://golang.org/)

## Run Service

```shell
Bash script
Usage: ./testapp.sh ImagaeName

Manual Steps

${DOCKER} build -t ImageName .

${DOCKER} run -i -t --rm -p 8080:8080 ${1}

```

## Check The working of App

localhost:8080

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     PaxHeader/common_test.go                                                                            000644  777777  777777  00000000275 13461551753 022237  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.156830013
30 ctime=1556534251.156883335
30 atime=1556538769.650588713
23 SCHILY.dev=16777220
22 SCHILY.ino=3936202
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   common_test.go                                                                                      000644  �   UU��   ]�K(00000002320 13461551753 020703  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         package main

import (
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/gin-gonic/gin"
)

var tmpUserList []user
var tmpArticleList []article

func TestMain(m *testing.M) {
	//Set Gin to Test Mode
	gin.SetMode(gin.TestMode)

	// Run the other tests
	os.Exit(m.Run())
}

func getRouter(withTemplates bool) *gin.Engine {
	r := gin.Default()
	if withTemplates {
		r.LoadHTMLGlob("templates/*")
		r.Use(setUserStatus())
	}
	return r
}

func testHTTPResponse(t *testing.T, r *gin.Engine, req *http.Request, f func(w *httptest.ResponseRecorder) bool) {

	// Create a response recorder
	w := httptest.NewRecorder()

	// Create the service and process the above request.
	r.ServeHTTP(w, req)

	if !f(w) {
		t.Fail()
	}
}

// test methods
func testMiddlewareRequest(t *testing.T, r *gin.Engine, expectedHTTPCode int) {
	// Create a request to send to the above route
	req, _ := http.NewRequest("GET", "/", nil)

	// Process the request and test the response
	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		return w.Code == expectedHTTPCode
	})
}

func saveLists() {
	tmpUserList = userList
	tmpArticleList = articleList
}

func restoreLists() {
	userList = tmpUserList
	articleList = tmpArticleList
}
                                                                                                                                                                                                                                                                                                                PaxHeader/handlers.article.go                                                                       000644  777777  777777  00000000275 13461551753 023132  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.157014763
30 ctime=1556534251.157085843
30 atime=1556538769.650564738
23 SCHILY.dev=16777220
22 SCHILY.ino=3936203
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   handlers.article.go                                                                                 000644  �   UU��   ]�K(00000002136 13461551753 021603  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // handlers.article.go

package main

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func showIndexPage(c *gin.Context) {
	articles := getAllArticles()

	render(c, gin.H{
		"title":   "Home Page",
		"payload": articles}, "index.html")
}

func showArticleCreationPage(c *gin.Context) {
	render(c, gin.H{
		"title": "Create New Article"}, "create-article.html")
}

func getArticle(c *gin.Context) {
	if articleID, err := strconv.Atoi(c.Param("article_id")); err == nil {
		// Check if the article exists
		if article, err := getArticleByID(articleID); err == nil {
			render(c, gin.H{
				"title":   article.Title,
				"payload": article}, "article.html")

		} else {
			c.AbortWithError(http.StatusNotFound, err)
		}

	} else {
		c.AbortWithStatus(http.StatusNotFound)
	}
}

func createArticle(c *gin.Context) {
	title := c.PostForm("title")
	content := c.PostForm("content")

	if a, err := createNewArticle(title, content); err == nil {
		render(c, gin.H{
			"title":   "Submission Successful",
			"payload": a}, "submission-successful.html")
	} else {
		c.AbortWithStatus(http.StatusBadRequest)
	}
}
                                                                                                                                                                                                                                                                                                                                                                                                                                  PaxHeader/handlers.article_test.go                                                                  000644  777777  777777  00000000275 13461551753 024171  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.157253053
30 ctime=1556534251.157312401
30 atime=1556538769.650618095
23 SCHILY.dev=16777220
22 SCHILY.ino=3936204
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   handlers.article_test.go                                                                            000644  �   UU��   ]�K(00000012621 13461551753 022642  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // handlers.article_test.go

package main

import (
	"encoding/json"
	"encoding/xml"
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"net/url"
	"strconv"
	"strings"
	"testing"
)

func TestShowIndexPageUnauthenticated(t *testing.T) {
	r := getRouter(true)

	r.GET("/", showIndexPage)

	req, _ := http.NewRequest("GET", "/", nil)

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		pageOK := err == nil && strings.Index(string(p), "<title>Home Page</title>") > 0

		return statusOK && pageOK
	})
}

func TestShowIndexPageAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.GET("/", showIndexPage)

	req, _ := http.NewRequest("GET", "/", nil)
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}

	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fail()
	}

	p, err := ioutil.ReadAll(w.Body)
	if err != nil || strings.Index(string(p), "<title>Home Page</title>") < 0 {
		t.Fail()
	}

}

func TestArticleUnauthenticated(t *testing.T) {
	r := getRouter(true)

	r.GET("/article/view/:article_id", getArticle)

	req, _ := http.NewRequest("GET", "/article/view/1", nil)

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		pageOK := err == nil && strings.Index(string(p), "<title>Article 1</title>") > 0

		return statusOK && pageOK
	})
}

func TestArticleAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	// Get a new router
	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.GET("/article/view/:article_id", getArticle)

	req, _ := http.NewRequest("GET", "/article/view/1", nil)
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}

	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fail()
	}

	// Test that the page title is "Article 1"
	p, err := ioutil.ReadAll(w.Body)
	if err != nil || strings.Index(string(p), "<title>Article 1</title>") < 0 {
		t.Fail()
	}

}

func TestArticleListJSON(t *testing.T) {
	r := getRouter(true)

	r.GET("/", showIndexPage)

	req, _ := http.NewRequest("GET", "/", nil)
	req.Header.Add("Accept", "application/json")

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		if err != nil {
			return false
		}
		var articles []article
		err = json.Unmarshal(p, &articles)

		return err == nil && len(articles) >= 2 && statusOK
	})
}

func TestArticleXML(t *testing.T) {
	r := getRouter(true)

	r.GET("/article/view/:article_id", getArticle)

	req, _ := http.NewRequest("GET", "/article/view/1", nil)
	req.Header.Add("Accept", "application/xml")

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		if err != nil {
			return false
		}
		var a article
		err = xml.Unmarshal(p, &a)

		return err == nil && a.ID == 1 && len(a.Title) >= 0 && statusOK
	})
}

func TestArticleCreationPageAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.GET("/article/create", ensureLoggedIn(), showArticleCreationPage)

	req, _ := http.NewRequest("GET", "/article/create", nil)
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}

	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fail()
	}

	p, err := ioutil.ReadAll(w.Body)
	if err != nil || strings.Index(string(p), "<title>Create New Article</title>") < 0 {
		t.Fail()
	}

}

func TestArticleCreationPageUnauthenticated(t *testing.T) {
	r := getRouter(true)

	r.GET("/article/create", ensureLoggedIn(), showArticleCreationPage)

	req, _ := http.NewRequest("GET", "/article/create", nil)

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		return w.Code == http.StatusUnauthorized
	})
}

func TestArticleCreationAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.POST("/article/create", ensureLoggedIn(), createArticle)

	articlePayload := getArticlePOSTPayload()
	req, _ := http.NewRequest("POST", "/article/create", strings.NewReader(articlePayload))
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(articlePayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fail()
	}

	p, err := ioutil.ReadAll(w.Body)
	if err != nil || strings.Index(string(p), "<title>Submission Successful</title>") < 0 {
		t.Fail()
	}

}

func TestArticleCreationUnauthenticated(t *testing.T) {
	r := getRouter(true)

	r.POST("/article/create", ensureLoggedIn(), createArticle)

	articlePayload := getArticlePOSTPayload()
	req, _ := http.NewRequest("POST", "/article/create", strings.NewReader(articlePayload))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(articlePayload)))

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		return w.Code == http.StatusUnauthorized
	})
}

func getArticlePOSTPayload() string {
	params := url.Values{}
	params.Add("title", "Test Article Title")
	params.Add("content", "Test Article Content")

	return params.Encode()
}
                                                                                                               PaxHeader/handlers.user.go                                                                          000644  777777  777777  00000000274 13461551753 022464  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
29 mtime=1556534251.15742788
30 ctime=1556534251.157480282
30 atime=1556538769.650603732
23 SCHILY.dev=16777220
22 SCHILY.ino=3936205
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                    handlers.user.go                                                                                    000644  �   UU��   ]�K(00000003034 13461551753 021134  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // handlers.user.go

package main

import (
	"math/rand"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func showLoginPage(c *gin.Context) {
	render(c, gin.H{
		"title": "Login",
	}, "login.html")
}

func performLogin(c *gin.Context) {
	username := c.PostForm("username")
	password := c.PostForm("password")

	if isUserValid(username, password) {
		token := generateSessionToken()
		c.SetCookie("token", token, 3600, "", "", false, true)
		c.Set("is_logged_in", true)

		render(c, gin.H{
			"title": "Successful Login"}, "login-successful.html")

	} else {
		c.HTML(http.StatusBadRequest, "login.html", gin.H{
			"ErrorTitle":   "Login Failed",
			"ErrorMessage": "Invalid credentials provided"})
	}
}

func generateSessionToken() string {
	return strconv.FormatInt(rand.Int63(), 16)
}

func logout(c *gin.Context) {
	c.SetCookie("token", "", -1, "", "", false, true)

	c.Redirect(http.StatusTemporaryRedirect, "/")
}

func showRegistrationPage(c *gin.Context) {
	render(c, gin.H{
		"title": "Register"}, "register.html")
}

func register(c *gin.Context) {
	username := c.PostForm("username")
	password := c.PostForm("password")

	if _, err := registerNewUser(username, password); err == nil {
		token := generateSessionToken()
		c.SetCookie("token", token, 3600, "", "", false, true)
		c.Set("is_logged_in", true)

		render(c, gin.H{
			"title": "Successful registration & Login"}, "login-successful.html")

	} else {
		c.HTML(http.StatusBadRequest, "register.html", gin.H{
			"ErrorTitle":   "Registration Failed",
			"ErrorMessage": err.Error()})

	}
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    PaxHeader/handlers.user_test.go                                                                     000644  777777  777777  00000000275 13461551753 023524  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.157605401
30 ctime=1556534251.157658715
30 atime=1556538769.650582615
23 SCHILY.dev=16777220
22 SCHILY.ino=3936206
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   handlers.user_test.go                                                                               000644  �   UU��   ]�K(00000013330 13461551753 022173  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // handlers.user_test.go

package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"net/url"
	"strconv"
	"strings"
	"testing"
)

func TestShowLoginPageAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.GET("/u/login", ensureNotLoggedIn(), showLoginPage)

	req, _ := http.NewRequest("GET", "/u/login", nil)
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}

	r.ServeHTTP(w, req)

	// Test that the http status code is 401
	if w.Code != http.StatusUnauthorized {
		t.Fail()
	}
}

func TestShowLoginPageUnauthenticated(t *testing.T) {
	r := getRouter(true)

	r.GET("/u/login", ensureNotLoggedIn(), showLoginPage)

	req, _ := http.NewRequest("GET", "/u/login", nil)

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		pageOK := err == nil && strings.Index(string(p), "<title>Login</title>") > 0

		return statusOK && pageOK
	})
}

func TestLoginAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.POST("/u/login", ensureNotLoggedIn(), performLogin)

	loginPayload := getLoginPOSTPayload()
	req, _ := http.NewRequest("POST", "/u/login", strings.NewReader(loginPayload))
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(loginPayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusUnauthorized {
		t.Fail()
	}
}

func TestLoginUnauthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	r.POST("/u/login", ensureNotLoggedIn(), performLogin)

	loginPayload := getLoginPOSTPayload()
	req, _ := http.NewRequest("POST", "/u/login", strings.NewReader(loginPayload))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(loginPayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fail()
	}

	p, err := ioutil.ReadAll(w.Body)
	if err != nil || strings.Index(string(p), "<title>Successful Login</title>") < 0 {
		t.Fail()
	}
}

func TestLoginUnauthenticatedIncorrectCredentials(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	r.POST("/u/login", ensureNotLoggedIn(), performLogin)

	loginPayload := getRegistrationPOSTPayload()
	req, _ := http.NewRequest("POST", "/u/login", strings.NewReader(loginPayload))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(loginPayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusBadRequest {
		t.Fail()
	}
}

func TestShowRegistrationPageAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.GET("/u/register", ensureNotLoggedIn(), showRegistrationPage)

	req, _ := http.NewRequest("GET", "/u/register", nil)
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}

	r.ServeHTTP(w, req)

	if w.Code != http.StatusUnauthorized {
		t.Fail()
	}
}

func TestShowRegistrationPageUnauthenticated(t *testing.T) {
	r := getRouter(true)

	r.GET("/u/register", ensureNotLoggedIn(), showRegistrationPage)

	req, _ := http.NewRequest("GET", "/u/register", nil)

	testHTTPResponse(t, r, req, func(w *httptest.ResponseRecorder) bool {
		statusOK := w.Code == http.StatusOK

		p, err := ioutil.ReadAll(w.Body)
		pageOK := err == nil && strings.Index(string(p), "<title>Register</title>") > 0

		return statusOK && pageOK
	})
}

func TestRegisterAuthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	r.POST("/u/register", ensureNotLoggedIn(), register)

	registrationPayload := getRegistrationPOSTPayload()
	req, _ := http.NewRequest("POST", "/u/register", strings.NewReader(registrationPayload))
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(registrationPayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusUnauthorized {
		t.Fail()
	}
}

func TestRegisterUnauthenticated(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	r.POST("/u/register", ensureNotLoggedIn(), register)

	registrationPayload := getRegistrationPOSTPayload()
	req, _ := http.NewRequest("POST", "/u/register", strings.NewReader(registrationPayload))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(registrationPayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusOK {
		t.Fail()
	}

	p, err := ioutil.ReadAll(w.Body)
	if err != nil || strings.Index(string(p), "<title>Successful registration &amp; Login</title>") < 0 {
		t.Fail()
	}
}

func TestRegisterUnauthenticatedUnavailableUsername(t *testing.T) {
	w := httptest.NewRecorder()

	r := getRouter(true)

	r.POST("/u/register", ensureNotLoggedIn(), register)

	registrationPayload := getLoginPOSTPayload()
	req, _ := http.NewRequest("POST", "/u/register", strings.NewReader(registrationPayload))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(registrationPayload)))

	r.ServeHTTP(w, req)

	if w.Code != http.StatusBadRequest {
		t.Fail()
	}
}

func getLoginPOSTPayload() string {
	params := url.Values{}
	params.Add("username", "user1")
	params.Add("password", "pass1")

	return params.Encode()
}

func getRegistrationPOSTPayload() string {
	params := url.Values{}
	params.Add("username", "u1")
	params.Add("password", "p1")

	return params.Encode()
}
                                                                                                                                                                                                                                                                                                        PaxHeader/main.go                                                                                   000644  777777  777777  00000000274 13461562336 020632  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
29 mtime=1556538590.95935333
30 ctime=1556538590.959833082
30 atime=1556538807.272908048
23 SCHILY.dev=16777220
22 SCHILY.ino=3943219
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                    main.go                                                                                             000644  �   UU��   ]�K(00000001763 13461562336 017311  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // main.go
// for any issue please write chauhanchander27@gmail.com

package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

var router *gin.Engine

func main() {
	// Set Gin to production mode
	gin.SetMode(gin.ReleaseMode)

	// Set the router as the default one provided by Gin
	router = gin.Default()

	// Process the templates at the start so that they don't have to be loaded
	// from the disk again.
	router.LoadHTMLGlob("templates/*")

	// Initialize the routes
	initializeRoutes()

	// Start serving the application
	router.Run()
}

func render(c *gin.Context, data gin.H, templateName string) {
	loggedInInterface, _ := c.Get("is_logged_in")
	data["is_logged_in"] = loggedInInterface.(bool)

	switch c.Request.Header.Get("Accept") {
	case "application/json":
		// Respond with JSON
		c.JSON(http.StatusOK, data["payload"])
	case "application/xml":
		// Respond with XML
		c.XML(http.StatusOK, data["payload"])
	default:
		// Respond with HTML
		c.HTML(http.StatusOK, templateName, data)
	}
}
             PaxHeader/middleware.auth.go                                                                        000644  777777  777777  00000000275 13461551753 022765  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.159415407
30 ctime=1556534251.159477829
30 atime=1556538769.650624205
23 SCHILY.dev=16777220
22 SCHILY.ino=3936215
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   middleware.auth.go                                                                                  000644  �   UU��   ]�K(00000001405 13461551753 021434  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // middleware.auth.go

package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func ensureLoggedIn() gin.HandlerFunc {
	return func(c *gin.Context) {
		loggedInInterface, _ := c.Get("is_logged_in")
		loggedIn := loggedInInterface.(bool)
		if !loggedIn {
			c.AbortWithStatus(http.StatusUnauthorized)
		}
	}
}

func ensureNotLoggedIn() gin.HandlerFunc {
	return func(c *gin.Context) {
		loggedInInterface, _ := c.Get("is_logged_in")
		loggedIn := loggedInInterface.(bool)
		if loggedIn {
			c.AbortWithStatus(http.StatusUnauthorized)
		}
	}
}

func setUserStatus() gin.HandlerFunc {
	return func(c *gin.Context) {
		if token, err := c.Cookie("token"); err == nil || token != "" {
			c.Set("is_logged_in", true)
		} else {
			c.Set("is_logged_in", false)
		}
	}
}
                                                                                                                                                                                                                                                           PaxHeader/middleware.auth_test.go                                                                   000644  777777  777777  00000000275 13461551753 024024  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.159629418
30 ctime=1556534251.159688249
30 atime=1556538769.650613027
23 SCHILY.dev=16777220
22 SCHILY.ino=3936216
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   middleware.auth_test.go                                                                             000644  �   UU��   ]�K(00000003647 13461551753 022505  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // middleware.auth_test.go

package main

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gin-gonic/gin"
)

func TestEnsureLoggedInUnauthenticated(t *testing.T) {
	r := getRouter(false)
	r.GET("/", setLoggedIn(false), ensureLoggedIn(), func(c *gin.Context) {
		t.Fail()
	})

	testMiddlewareRequest(t, r, http.StatusUnauthorized)
}

func TestEnsureLoggedInAuthenticated(t *testing.T) {
	r := getRouter(false)
	r.GET("/", setLoggedIn(true), ensureLoggedIn(), func(c *gin.Context) {
		c.Status(http.StatusOK)
	})

	testMiddlewareRequest(t, r, http.StatusOK)
}

func TestEnsureNotLoggedInAuthenticated(t *testing.T) {
	r := getRouter(false)
	r.GET("/", setLoggedIn(true), ensureNotLoggedIn(), func(c *gin.Context) {
		t.Fail()
	})

	testMiddlewareRequest(t, r, http.StatusUnauthorized)
}

func TestEnsureNotLoggedInUnauthenticated(t *testing.T) {
	r := getRouter(false)
	r.GET("/", setLoggedIn(false), ensureNotLoggedIn(), func(c *gin.Context) {
		c.Status(http.StatusOK)
	})

	testMiddlewareRequest(t, r, http.StatusOK)
}

func TestSetUserStatusAuthenticated(t *testing.T) {
	r := getRouter(false)
	r.GET("/", setUserStatus(), func(c *gin.Context) {
		loggedInInterface, exists := c.Get("is_logged_in")
		if !exists || !loggedInInterface.(bool) {
			t.Fail()
		}
	})

	w := httptest.NewRecorder()

	http.SetCookie(w, &http.Cookie{Name: "token", Value: "123"})

	req, _ := http.NewRequest("GET", "/", nil)
	req.Header = http.Header{"Cookie": w.HeaderMap["Set-Cookie"]}

	r.ServeHTTP(w, req)
}

func TestSetUserStatusUnauthenticated(t *testing.T) {
	r := getRouter(false)
	r.GET("/", setUserStatus(), func(c *gin.Context) {
		loggedInInterface, exists := c.Get("is_logged_in")
		if exists && loggedInInterface.(bool) {
			t.Fail()
		}
	})

	w := httptest.NewRecorder()

	req, _ := http.NewRequest("GET", "/", nil)

	r.ServeHTTP(w, req)
}

func setLoggedIn(b bool) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Set("is_logged_in", b)
	}
}
                                                                                         PaxHeader/models.article.go                                                                         000644  777777  777777  00000000274 13461553101 022601  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
29 mtime=1556534849.00128094
30 ctime=1556534849.001835044
30 atime=1556538769.650579704
23 SCHILY.dev=16777220
22 SCHILY.ino=3938794
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                    models.article.go                                                                                   000644  �   UU��   ]�K(00000001422 13461553101 021250  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // models.article.go

package main

import "errors"

type article struct {
	ID      int    `json:"id"`
	Title   string `json:"title"`
	Content string `json:"content"`
}

var articleList = []article{
	article{ID: 1, Title: "Knowledge Article 1", Content: "DevOps"},
	article{ID: 2, Title: "Knowledge Article 2", Content: "Infrastructure as a Code"},
}

func getAllArticles() []article {
	return articleList
}

func getArticleByID(id int) (*article, error) {
	for _, a := range articleList {
		if a.ID == id {
			return &a, nil
		}
	}
	return nil, errors.New("Knowledge Article not found")
}

func createNewArticle(title, content string) (*article, error) {
	a := article{ID: len(articleList) + 1, Title: title, Content: content}

	articleList = append(articleList, a)

	return &a, nil
}
                                                                                                                                                                                                                                              PaxHeader/models.article_test.go                                                                    000644  777777  777777  00000000275 13461551753 023654  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.160046713
30 ctime=1556534251.160135784
30 atime=1556538769.650576401
23 SCHILY.dev=16777220
22 SCHILY.ino=3936218
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   models.article_test.go                                                                              000644  �   UU��   ]�K(00000001556 13461551753 022332  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // models.article_test.go

package main

import "testing"

func TestGetAllArticles(t *testing.T) {
	alist := getAllArticles()

	if len(alist) != len(articleList) {
		t.Fail()
	}

	for i, v := range alist {
		if v.Content != articleList[i].Content ||
			v.ID != articleList[i].ID ||
			v.Title != articleList[i].Title {

			t.Fail()
			break
		}
	}
}

func TestGetArticleByID(t *testing.T) {
	a, err := getArticleByID(1)

	if err != nil || a.ID != 1 || a.Title != "Article 1" || a.Content != "Article 1 body" {
		t.Fail()
	}
}

func TestCreateNewArticle(t *testing.T) {
	originalLength := len(getAllArticles())

	a, err := createNewArticle("New test title", "New test content")

	allArticles := getAllArticles()
	newLength := len(allArticles)

	if err != nil || newLength != originalLength+1 ||
		a.Title != "New test title" || a.Content != "New test content" {

		t.Fail()
	}
}
                                                                                                                                                  PaxHeader/models.user.go                                                                            000644  777777  777777  00000000275 13461551753 022150  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534251.160363912
30 ctime=1556534251.160425916
30 atime=1556538769.650601206
23 SCHILY.dev=16777220
22 SCHILY.ino=3936219
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   models.user.go                                                                                      000644  �   UU��   ]�K(00000002045 13461551753 020620  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // models.user.go

package main

import (
	"errors"
	"strings"
)

type user struct {
	Username string `json:"username"`
	Password string `json:"-"`
}

// For this demo, we're storing the user list in memory
var userList = []user{
	user{Username: "user1", Password: "pass1"},
	user{Username: "user2", Password: "pass2"},
	user{Username: "user3", Password: "pass3"},
}

func isUserValid(username, password string) bool {
	for _, u := range userList {
		if u.Username == username && u.Password == password {
			return true
		}
	}
	return false
}

func registerNewUser(username, password string) (*user, error) {
	if strings.TrimSpace(password) == "" {
		return nil, errors.New("The password can't be empty")
	} else if !isUsernameAvailable(username) {
		return nil, errors.New("The username isn't available")
	}

	u := user{Username: username, Password: password}

	userList = append(userList, u)

	return &u, nil
}

func isUsernameAvailable(username string) bool {
	for _, u := range userList {
		if u.Username == username {
			return false
		}
	}
	return true
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           PaxHeader/models.user_test.go                                                                       000644  777777  777777  00000000274 13461551753 023206  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
29 mtime=1556534251.16057239
30 ctime=1556534251.160631817
30 atime=1556538769.650591575
23 SCHILY.dev=16777220
22 SCHILY.ino=3936220
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                    models.user_test.go                                                                                 000644  �   UU��   ]�K(00000002037 13461551753 021660  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // models.user_test.go

package main

import "testing"

func TestUserValidity(t *testing.T) {
	if !isUserValid("user1", "pass1") {
		t.Fail()
	}

	if isUserValid("user2", "pass1") {
		t.Fail()
	}

	if isUserValid("user1", "") {
		t.Fail()
	}

	if isUserValid("", "pass1") {
		t.Fail()
	}

	if isUserValid("User1", "pass1") {
		t.Fail()
	}
}

func TestValidUserRegistration(t *testing.T) {
	saveLists()

	u, err := registerNewUser("newuser", "newpass")

	if err != nil || u.Username == "" {
		t.Fail()
	}

	restoreLists()
}

func TestInvalidUserRegistration(t *testing.T) {
	saveLists()

	u, err := registerNewUser("user1", "pass1")

	if err == nil || u != nil {
		t.Fail()
	}

	u, err = registerNewUser("newuser", "")

	if err == nil || u != nil {
		t.Fail()
	}

	restoreLists()
}

func TestUsernameAvailability(t *testing.T) {
	saveLists()

	if !isUsernameAvailable("newuser") {
		t.Fail()
	}

	if isUsernameAvailable("user1") {
		t.Fail()
	}

	registerNewUser("newuser", "newpass")

	if isUsernameAvailable("newuser") {
		t.Fail()
	}

	restoreLists()
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 PaxHeader/routes.go                                                                                 000644  777777  777777  00000000273 13461551753 021227  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
29 mtime=1556534251.16303002
30 ctime=1556534251.163123926
29 atime=1556538769.65060998
23 SCHILY.dev=16777220
22 SCHILY.ino=3936226
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                     routes.go                                                                                           000644  �   UU��   ]�K(00000001323 13461551753 017677  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         // routes.go

package main

func initializeRoutes() {

	router.Use(setUserStatus())

	router.GET("/", showIndexPage)

	userRoutes := router.Group("/u")
	{
		userRoutes.GET("/login", ensureNotLoggedIn(), showLoginPage)

		userRoutes.POST("/login", ensureNotLoggedIn(), performLogin)

		userRoutes.GET("/logout", ensureLoggedIn(), logout)

		userRoutes.GET("/register", ensureNotLoggedIn(), showRegistrationPage)

		userRoutes.POST("/register", ensureNotLoggedIn(), register)
	}

	articleRoutes := router.Group("/article")
	{
		articleRoutes.GET("/view/:article_id", getArticle)

		articleRoutes.GET("/create", ensureLoggedIn(), showArticleCreationPage)

		articleRoutes.POST("/create", ensureLoggedIn(), createArticle)
	}
}
                                                                                                                                                                                                                                                                                                             PaxHeader/templates                                                                                 000755  777777  777777  00000000356 13461553000 021270  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534784.579602517
30 ctime=1556534784.579602517
30 atime=1556540363.236367675
48 LIBARCHIVE.creationtime=1556534651.005121428
23 SCHILY.dev=16777220
22 SCHILY.ino=3938686
19 SCHILY.nlink=12
                                                                                                                                                                                                                                                                                  templates/                                                                                          000755  �   UU��   ]�K(00000000000 13461553000 020011  5                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         templates/PaxHeader/index.html                                                                      000644  777777  777777  00000000275 13461552573 023355  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534651.005665245
30 ctime=1556534651.005758286
30 atime=1556538781.990493165
23 SCHILY.dev=16777220
22 SCHILY.ino=3938687
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/index.html                                                                                000644  �   UU��   ]�K(00000000567 13461552573 022034  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--index.html-->

{{ template "header.html" .}}

  <!--Loop over the `payload` variable, which is the list of articles-->
  {{range .payload }}
    <a href="/article/view/{{.ID}}">
      <!--Display the title of the article -->
      <h2>{{.Title}}</h2>
    </a>
    <!--Display the content of the article-->
    <p>{{.Content}}</p>
  {{end}}

{{ template "footer.html" .}}
                                                                                                                                         templates/PaxHeader/submission-successful.html                                                      000644  777777  777777  00000000274 13461553000 026577  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534784.475667029
30 ctime=1556534784.476222747
29 atime=1556538781.99050902
23 SCHILY.dev=16777220
22 SCHILY.ino=3938770
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                    templates/submission-successful.html                                                                000644  �   UU��   ]�K(00000000361 13461553000 025247  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--submission-successful.html-->

{{ template "header.html" .}}

<div>
  <strong>The article was successfully submitted.</strong>
  
  <a href="/article/view/{{.payload.ID}}">{{.payload.Title}}</a>
</div>
    
{{ template "footer.html" .}}
                                                                                                                                                                                                                                                                               templates/PaxHeader/article.html                                                                    000644  777777  777777  00000000275 13461552573 023671  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534651.006312121
30 ctime=1556534651.006396011
30 atime=1556538781.990480427
23 SCHILY.dev=16777220
22 SCHILY.ino=3938689
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/article.html                                                                              000644  �   UU��   ]�K(00000000336 13461552573 022342  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--article.html-->

{{ template "header.html" .}}

<!--Display the title of the article-->
<h1>{{.payload.Title}}</h1>

<!--Display the content of the article-->
<p>{{.payload.Content}}</p>

{{ template "footer.html" .}}
                                                                                                                                                                                                                                                                                                  templates/PaxHeader/register.html                                                                   000644  777777  777777  00000000275 13461552672 024072  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534714.558159793
30 ctime=1556534714.558655566
30 atime=1556538781.990505588
23 SCHILY.dev=16777220
22 SCHILY.ino=3938734
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/register.html                                                                             000644  �   UU��   ]�K(00000001530 13461552672 022540  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--register.html-->

{{ template "header.html" .}}

<h1>Register for KT Articles </h1>

<div class="panel panel-default col-sm-6">
  <div class="panel-body">
    {{ if .ErrorTitle}}
    <p class="bg-danger">
      {{.ErrorTitle}}: {{.ErrorMessage}}
    </p>
    {{end}}
    <form class="form" action="/u/register" method="POST">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="Username">
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" name="password" class="form-control" id="password" placeholder="Password">
      </div>
      <button type="submit" class="btn btn-primary">Register</button>
    </form>
  </div>
</div>  

    
{{ template "footer.html" .}}
                                                                                                                                                                        templates/PaxHeader/login-successful.html                                                           000644  777777  777777  00000000275 13461552573 025533  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534651.006860034
30 ctime=1556534651.006958788
30 atime=1556538781.990496426
23 SCHILY.dev=16777220
22 SCHILY.ino=3938691
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/login-successful.html                                                                     000644  �   UU��   ]�K(00000000245 13461552573 024203  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--login-successful.html-->

{{ template "header.html" .}}

<div>
  Congratulatiosn !!!  You have successfully logged in.
</div>
    
{{ template "footer.html" .}}
                                                                                                                                                                                                                                                                                                                                                           templates/PaxHeader/menu.html                                                                       000644  777777  777777  00000000275 13461552763 023213  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534771.614071535
30 ctime=1556534771.614606605
30 atime=1556538781.990502583
23 SCHILY.dev=16777220
22 SCHILY.ino=3938763
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/menu.html                                                                                 000644  �   UU��   ]�K(00000001310 13461552763 021655  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--menu.html-->

<nav class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="/">
        Home
      </a>
    </div>
    <ul class="nav navbar-nav">
      {{ if .is_logged_in }}
        <!--Display this link only when the user is logged in-->
        <li><a href="/article/create">Create knowledge Articles</a></li>
      {{end}} 
      {{ if not .is_logged_in }}
        <li><a href="/u/register">Register</a></li>
      {{end}} 
      {{ if not .is_logged_in }}
        <li><a href="/u/login">Login</a></li>
      {{end}} 
      {{ if .is_logged_in }}
        <li><a href="/u/logout">Logout</a></li>
      {{end}}
    </ul>
  </div>
</nav>
                                                                                                                                                                                                                                                                                                                        templates/PaxHeader/login.html                                                                      000644  777777  777777  00000000275 13461552573 023356  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534651.007867466
30 ctime=1556534651.007949225
30 atime=1556538781.990499506
23 SCHILY.dev=16777220
22 SCHILY.ino=3938693
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/login.html                                                                                000644  �   UU��   ]�K(00000001470 13461552573 022027  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--login.html-->

{{ template "header.html" .}}

<h1>Login</h1>


<div class="panel panel-default col-sm-6">
  <div class="panel-body">
    {{ if .ErrorTitle}}
    <p class="bg-danger">
      {{.ErrorTitle}}: {{.ErrorMessage}}
    </p>
    {{end}}
    <form class="form" action="/u/login" method="POST">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="Username">
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Password">
      </div>
      <button type="submit" class="btn btn-primary">Login</button>
    </form>
  </div>
</div>  


{{ template "footer.html" .}}
                                                                                                                                                                                                        templates/PaxHeader/create-article.html                                                             000644  777777  777777  00000000275 13461552707 025131  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534727.536328589
30 ctime=1556534727.536828195
30 atime=1556538781.990483768
23 SCHILY.dev=16777220
22 SCHILY.ino=3938743
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/create-article.html                                                                       000644  �   UU��   ]�K(00000001523 13461552707 023601  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--create-article.html-->

{{ template "header.html" .}}

<h1>Create Article</h1>


<div class="panel panel-default col-sm-12">
  <div class="panel-body">
    {{ if .ErrorTitle}}
    <p class="bg-danger">
      {{.ErrorTitle}}: {{.ErrorMessage}}
    </p>
    {{end}}
    <form class="form" action="/article/create" method="POST">
      <div class="form-group">
        <label for="title">Title</label>
        <input type="text" class="form-control" id="title" name="title" placeholder="Title">
      </div>
      <div class="form-group">
        <label for="content">Content</label>
        <textarea name="content" class="form-control" rows="10" id="content" placeholder="Article Content"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
  </div>
</div>  

    
{{ template "footer.html" .}}
                                                                                                                                                                             templates/PaxHeader/footer.html                                                                     000644  777777  777777  00000000275 13461552573 023544  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534651.008380911
30 ctime=1556534651.008451252
30 atime=1556538781.990486873
23 SCHILY.dev=16777220
22 SCHILY.ino=3938695
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/footer.html                                                                               000644  �   UU��   ]�K(00000000046 13461552573 022213  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--footer.html-->

  </body>

</html>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          templates/PaxHeader/header.html                                                                     000644  777777  777777  00000000275 13461552573 023476  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556534651.008597317
30 ctime=1556534651.008659737
30 atime=1556538781.990489967
23 SCHILY.dev=16777220
22 SCHILY.ino=3938696
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   templates/header.html                                                                               000644  �   UU��   ]�K(00000001351 13461552573 022145  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         <!--header.html-->

<!doctype html>
<html>

  <head>
    <title>{{ .title }}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8">
    
    <!--Use bootstrap to make the application look decent-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <script async src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
  </head>

  <body class="container">
    {{ template "menu.html" . }}
                                                                                                                                                                                                                                                                                       PaxHeader/testapp.sh                                                                                000755  777777  777777  00000000275 13461562315 021374  x                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         18 gid=1573931816
18 uid=1431667228
30 mtime=1556538573.845506498
30 ctime=1556538573.845711635
30 atime=1556538807.272949165
23 SCHILY.dev=16777220
22 SCHILY.ino=3943211
18 SCHILY.nlink=1
                                                                                                                                                                                                                                                                                                                                   testapp.sh                                                                                          000755  �   UU��   ]�K(00000000546 13461562315 020050  0                                                                                                    ustar 00chander.singh                   SANJUAN\Domain Users            000000  000000                                                                                                                                                                         #!/bin/bash

export GO=`which go`
export DOCKER=`which docker`
export KUBECTL=`which kubectl`
export CURL=`which curl`

if [ "$#" -ne 1 ]; then
   echo "Usage: $0 ImagaeName" >&2
   exit 1
fi

# Run Unit Tests 

export TEST_RESULT=`"${GO}" test -v .`

# Build images
${DOCKER} build -t ${1} .

# Run application

${DOCKER} run -i -t --rm -p 8080:8080 ${1}
 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
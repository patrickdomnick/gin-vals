package main

import (
	"fmt"
	"unicode/utf8"

	"github.com/gin-gonic/gin"
	"github.com/variantdev/vals"
)

func main() {
	// Initialize Webserver
	r := gin.Default()

	// One Global Route for Everything
	r.GET("/*ref", func(c *gin.Context) {
		ref := c.Param("ref")
		// Trim Initial /
		_, i := utf8.DecodeRuneInString(ref)
		fixedRef := ref[i:]
		// Initialize Vals
		runtime, err := vals.New(vals.Options{
			CacheSize: 1,
		})
		if err != nil {
			c.Error(err)
		}
		// Get Secret via Vals
		val, err := runtime.Eval(map[string]interface{}{
			"value": fixedRef,
		})
		if err != nil {
			c.Error(err)
		}
		// Return Secret as String
		c.String(200, string(fmt.Sprintf("%v", val["value"])))
	})
	r.Run("0.0.0.0:9090")
}

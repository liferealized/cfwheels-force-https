<cfcomponent mixin="controller" output="false">
    
  <cffunction name="init" access="public" output="false" returntype="any">
    <cfscript>
      this.version = "1.1.8";
    </cfscript>
    <cfreturn this />
  </cffunction>

  <cffunction name="forceHttps" access="public" output="false" returntype="void">
    <cfargument name="cgiParameterName" type="string" required="false" default="SERVER_PORT" />
    <cfscript>
      variables.$class.forcehttps = duplicate(arguments);
      filters(through="_forceHttps");
    </cfscript>
  </cffunction>

  <!--- controller helpers --->

  <cffunction name="_forceHttps" access="public" output="false" returntype="void">
    <cfargument name="forwardedPort" type="string" required="false" default="#cgi[variables.$class.forcehttps.cgiParameterName]#" />
    <cfscript>
      var loc = { args = {} };

      if (len(arguments.forwardedPort) and arguments.forwardedPort != "443")
      {
        // get our key params
        for (loc.item in params)
          if (loc.item contains "key" or loc.item eq "action")
            loc.args[loc.item] = params[loc.item];

        redirectTo(route=params.route, protocol="https", onlyPath=false, statusCode=301, argumentCollection=loc.args);
      }
    </cfscript>
  </cffunction>


</cfcomponent>
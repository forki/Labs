﻿using Owin;
using System.Web.Http;

namespace Code.Service
{
    public class Startup
    {
        public void Configuration(IAppBuilder builder)
        {
            // Configure Web API for self-host. 
            var config = new HttpConfiguration();
            //todo: need to assign IoC resolver
           
            config.Routes.MapHttpRoute(
                name: "Default",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            config.Routes.MapHttpRoute(
                name: "AddApi",
                routeTemplate: "api/{controller}/add"
            );

            //config.Routes.MapHttpRoute(
            //    name: "AddItemsApi",
            //    routeTemplate: "api/{controller}/additems"
            //);

            builder.UseWebApi(config);
        }
    }
}

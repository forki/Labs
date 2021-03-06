﻿using Castle.MicroKernel.Registration;
using Castle.MicroKernel.SubSystems.Configuration;
using Castle.Windsor;
using Log.Common;
using Log.Provider.Default;

namespace Log.Service
{
    public class LogInstaller : IWindsorInstaller
    {
        public void Install(IWindsorContainer container, IConfigurationStore store)
        {
            container.Register(
                Component.For<ILogProvider>()
                    .ImplementedBy<CustomFileProvider>()
                    .DependsOn(Dependency.OnAppSettingsValue("networkPath"),
                        Dependency.OnAppSettingsValue("path"),
                        Dependency.OnAppSettingsValue("name"),
                        Dependency.OnValue<IEntryProvider>(new CustomEntryProvider()))
                    .LifestyleSingleton(),

                Component.For<ILogServices>()
                    .ImplementedBy<LogServices>()
                    .DependsOn(Dependency.OnAppSettingsValue("maxItems"))
                    .LifestyleSingleton(),

                Component.For<IServiceable>()
                    .ImplementedBy<WebApiApp>()
                    .DependsOn(Dependency.OnAppSettingsValue("port"))
                    .LifestyleTransient(),

                Component.For<ItemsController>()
                    .LifestyleTransient(),

                Component.For<LogService>()
                    .LifestyleSingleton()
                );
        }
    }
}

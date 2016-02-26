﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interviewer.Data
{
    public class InterViewerContext: DbContext
    {
        public InterViewerContext()
            :base(@"Data Source=(localdb)\ProjectsV12;Initial Catalog=Interviewer;Integrated Security=True")
        {
        }
        public DbSet<Platform> Platforms { get; set; }
        public DbSet<KnowledgeArea> KnowledgeAreas { get; set; }
        public DbSet<Area> Areas { get; set; }
        public DbSet<Question> Questions { get; set; }
    }
}

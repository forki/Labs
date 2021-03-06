using Interviewer.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Windows.Input;
using System.Xml.Serialization;
using WpfInterviewer.Views;

namespace WpfInterviewer
{
	public class MainViewModel : BaseModel
	{
		private class RunTestCommand : ICommand
		{
			public event EventHandler CanExecuteChanged;

			public bool CanExecute(object parameter)
			{
				return !MainViewModel.ViewModel.IsRunning;
			}

			public void Execute(object parameter)
			{
				MainViewModel.ViewModel.RunQuestions(int.Parse(parameter.ToString()));
			}
		}

		private class RunQuestionCommand : ICommand
		{
			private readonly int _rating;

			public event EventHandler CanExecuteChanged;

			public RunQuestionCommand(int rating)
			{
				_rating = rating;
			}

			public bool CanExecute(object parameter)
			{
				return MainViewModel.ViewModel.SelectedQuestion != null;
			}

			public void Execute(object parameter)
			{
				MainViewModel.ViewModel.QuestionAnswered(_rating, parameter as Question);
			}
		}

        private class RunShowAddQuestionsCommand : ICommand
        {
            public event EventHandler CanExecuteChanged;

            public RunShowAddQuestionsCommand()
            {
            }

            public bool CanExecute(object parameter)
            {
                return null != MainViewModel.ViewModel.SelectedArea;
            }

            public void Execute(object parameter)
            {
                new AddQuestions().ShowDialog();
            }
        }

		private static MainViewModel _viewModel;

		private configuration _selectedConfiguration;
		private Profile _selectedProfile;
		private Platform _selectedPlatform;
		private KnowledgeArea _selectedKnowledgeArea;
		private Area _selectedArea;
		private Question _selectedQuestion;

		private int _maxQuestionsCount = 10;
		private int _questionsCount = 5;
		private bool _isLoaded = false;
		private bool _isRunning = false;

		private int _passedCount = 0;
		private int _failedCount = 0;
		private int _undefinedCount = 0;
        private int _totalQuestions = 0;

		private string _interviewedPerson;

		public static MainViewModel ViewModel
		{
			get
			{
			    if (null == _viewModel)
			    {
			        _viewModel = new MainViewModel();
			        _viewModel.LoadConfiguration(
                        Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                        ConfigurationManager.AppSettings["DefaultConfiguration"])
                    );
			    }
                return _viewModel;
			}
		}

		public configuration SelectedConfiguration
		{
			get
			{
				return _selectedConfiguration;
			}
			set
			{
				_selectedConfiguration = value;

				OnPropertyChanged("SelectedConfiguration");
				OnPropertyChanged("Platforms");
				OnPropertyChanged("Profiles");
				OnPropertyChanged("QuestionsCountRange");
			}
		}

		public IEnumerable<Profile> Profiles
		{
			get
			{
                SelectedProfile = SelectedConfiguration.Profile.FirstOrDefault();
				return SelectedConfiguration.Profile;
			}
		}

		public Profile SelectedProfile
		{
			get
			{
				return _selectedProfile;
			}
			set
			{
				_selectedProfile = value;
				OnPropertyChanged("SelectedProfile");
			}
		}

		public IEnumerable<Platform> Platforms
		{
			get
			{
                SelectedPlatform = SelectedConfiguration.Platform.FirstOrDefault();
				return SelectedConfiguration.Platform;
			}
		}

		public Platform SelectedPlatform
		{
			get
			{
				return _selectedPlatform;
			}
			set
			{
				_selectedPlatform = value;
				OnPropertyChanged("SelectedPlatform");
			    if (value == null) return;

				SelectedKnowledgeArea = value.KnowledgeArea.FirstOrDefault();
			}
		}

		public KnowledgeArea SelectedKnowledgeArea
		{
			get
			{
				return _selectedKnowledgeArea;
			}
			set
			{
				_selectedKnowledgeArea = value;
				OnPropertyChanged("SelectedKnowledgeArea");
			    if (value == null) return;

				SelectedArea = value.Area.FirstOrDefault();
			}
		}

		public Area SelectedArea
		{
			get
			{
				return _selectedArea;
			}
			set
			{
				_selectedArea = value;
				OnPropertyChanged("SelectedArea");
                if (value == null) return;
                
                SelectedQuestion = value.Question.FirstOrDefault();
			}
		}

		public Question SelectedQuestion
		{
			get
			{
				return _selectedQuestion;
			}
			set
			{
				_selectedQuestion = value;
				OnPropertyChanged("SelectedQuestion");
			}
		}

		public int QuestionsCount
		{
			get
			{
				return _questionsCount;
			}
			set
			{
				_questionsCount = value;
				OnPropertyChanged("QuestionsCount");
			}
		}

		public IEnumerable<int> QuestionsCountRange
		{
			get
			{
				var list = new List<int>();
				for (var i = 1; i <= _maxQuestionsCount; i++)
				{
					list.Add(i);
				}
				return list;
			}
		}

		public bool IsRunning
		{
			get
			{
				return _isRunning;
			}
			set
			{
				_isRunning = value;
				OnPropertyChanged("IsRunning");
			}
		}

        private ICommand _runQuestionsCommand;
        public ICommand RunQuestionsCommand
		{
			get
			{
				return _runQuestionsCommand ?? (_runQuestionsCommand = new MainViewModel.RunTestCommand());
			}
		}

        private ICommand _questionUpCommand;
        public ICommand QuestionUpCommand
		{
			get
			{
				return _questionUpCommand ?? (_questionUpCommand = new MainViewModel.RunQuestionCommand(1));
			}
		}

        private ICommand _questionDownCommand;
        public ICommand QuestionDownCommand
		{
			get
			{
                return _questionDownCommand ?? (_questionDownCommand = new MainViewModel.RunQuestionCommand(0));
			}
		}

        private ICommand _questionUndefCommand;
        public ICommand QuestionUndefCommand
		{
			get
			{
                return _questionUndefCommand ?? (_questionUndefCommand = new MainViewModel.RunQuestionCommand(-1));
			}
		}

        private ICommand _showAddQuestionsCommand;
        public ICommand ShowAddQuestionsCommand
        {
            get
            {
                return _showAddQuestionsCommand ?? (_showAddQuestionsCommand = new MainViewModel.RunShowAddQuestionsCommand());
            }
        }

		public int PassedCount
		{
			get
			{
				return _passedCount;
			}
			set
			{
				_passedCount = value;
				OnPropertyChanged("PassedCount");
                OnPropertyChanged("AppliedQuestions");
            }
		}

		public int FailedCount
		{
			get
			{
				return _failedCount;
			}
			set
			{
				_failedCount = value;
				OnPropertyChanged("FailedCount");
                OnPropertyChanged("AppliedQuestions");
            }
		}

		public int UndefinedCount
		{
			get
			{
				return _undefinedCount;
			}
			set
			{
				_undefinedCount = value;
				OnPropertyChanged("UndefinedCount");
                OnPropertyChanged("AppliedQuestions");
            }
		}

        public int TotalQuestions
        {
            get
            {
                return _totalQuestions;
            }
            set
            {
                _totalQuestions = value;
                PassedCount = 0;
                FailedCount = 0;
                UndefinedCount = 0;
                OnPropertyChanged("TotalQuestions");
                OnPropertyChanged("AppliedQuestions");
            }
        }

        public int AppliedQuestions
        {
            get
            {
                return Math.Min(TotalQuestions, PassedCount + FailedCount + UndefinedCount + 1);
            }
        }

        public string InterviewedPerson
		{
			get
			{
				return _interviewedPerson;
			}
			set
			{
				_interviewedPerson = value;
				OnPropertyChanged("InterviewedPerson");
			}
		}

		private void LoadConfiguration(string fileName)
		{
			if (!_isLoaded)
			{
				if (File.Exists(fileName))
				{
					var ser = new XmlSerializer(typeof(configuration));
					using (var stream = new StreamReader(fileName))
					{
						SelectedConfiguration = (configuration)ser.Deserialize(stream);
					}
					_isLoaded = true;
				}
			}
		}

		private void QuestionAnswered(int rating, Question question)
		{
            SelectedQuestion = question;
            SelectedQuestion.AlreadyAnswered = true;
            SelectedQuestion.rating = rating;
			switch (rating)
			{
			case -1:
				UndefinedCount++;
				break;
			case 0:
				FailedCount++;
				break;
			case 1:
				PassedCount++;
				break;
			}

            SelectedQuestion = GetNextQuestion();
		}

		private void RunQuestions(int mode)
		{
			IsRunning = true;
			try
			{
				if (mode == 1) //get random questions
				{
					ToogleAnsweredFlag(true);

				    var questions = from p in Platforms
				        from ka in p.KnowledgeArea
				        from a in ka.Area
				        select a.Question;

				    foreach (var q in questions.Where(x => x.Count > 0))
				    {
				        var randomIndexes = GetRandomIndexes(q.Count);
				        foreach (var i in randomIndexes)
				        {
				            q.ElementAt(i).AlreadyAnswered = false;
				        }
				    }

                    TotalQuestions = GetPendingQuestions();
                    //TransformInterviewDataToCsv();
                    //TransformInterviewDataToSQL();
                }
				else
				{
					ToogleAnsweredFlag(false);
				}
				OnPropertyChanged("Platforms");

                if(mode == 1)
                {
                    var window = new AskQuestions();
                    var result = window.ShowDialog();
                    if(result.HasValue && result.Value)
                    {
                    }
                }
			}
			finally
			{
				IsRunning = false;
			}
		}

	    private IEnumerable<int> GetRandomIndexes(int itemsCount)
	    {
            var rand = new Random(100);
	        var list = new List<int>();
	        if (itemsCount <= QuestionsCount)
	        {
                for(var i=0;i<itemsCount;i++)
                    list.Add(i);
	        }
	        else
	        {
	            if (Math.Floor(Convert.ToDecimal(itemsCount)/Convert.ToDecimal(QuestionsCount)) >= 2M)
	            {
	                while (list.Count < Math.Min(QuestionsCount, itemsCount))
	                {
	                    var randIndex = rand.Next(0, itemsCount - 1);
	                    if (!list.Contains(randIndex))
	                        list.Add(randIndex);
	                }
	            }
	            else
	            {
	                var dismissList = new List<int>();
	                for (var i = 0; i < itemsCount - QuestionsCount; i++)
	                {
                        var randIndex = rand.Next(0, itemsCount - 1);
                        if (!dismissList.Contains(randIndex))
                            dismissList.Add(randIndex);
	                }

                    for (var i = 0; i < itemsCount; i++)
                        if(!dismissList.Contains(i))
                            list.Add(i);
	            }
	        }

	        return list.ToArray();
	    }

		private void ToogleAnsweredFlag(bool answered)
		{
			foreach (var q2 in from p in Platforms
			    from ka in p.KnowledgeArea
			    from a in ka.Area
			    from q in a.Question
			select q)
			{
				q2.AlreadyAnswered = answered;
			}
		}

        private int GetPendingQuestions()
        {
            var pendingQuestions = 0;
            foreach (var q2 in from p in Platforms
                               from ka in p.KnowledgeArea
                               from a in ka.Area
                               from q in a.Question
                               select q)
            {
                pendingQuestions += q2.AlreadyAnswered ? 0 : 1;
            }

            return pendingQuestions;
        }

        private Question GetNextQuestion()
        {
            foreach(var p in Platforms)
            {
                foreach(var ka in p.KnowledgeArea)
                {
                    foreach(var a in ka.Area)
                    {
                        foreach(var q in a.Question)
                        {
                            if (!q.AlreadyAnswered)
                            {
                                if (p != SelectedPlatform)
                                    SelectedPlatform = p;

                                if (ka != SelectedKnowledgeArea)
                                    SelectedKnowledgeArea = ka;

                                if (a != SelectedArea)
                                    SelectedArea = a;

                                return q;
                            }
                        }
                    }
                }
            }

            return null;
        }

        private void TransformInterviewDataToCsv()
        {
            var pc = 0;
            var kac = 0;
            var ac = 0;
            var qc = 0;
            using (var pstream = File.CreateText(
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "platforms.csv")))
            {
                using (var kastream = File.CreateText(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "knowledgeareas.csv")))
                {
                    using (var astream = File.CreateText(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "areas.csv")))
                    {
                        using (var qstream = File.CreateText(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "questions.csv")))
                        {
                            pstream.WriteLine("Id,Name");
                            kastream.WriteLine("PlatformId,Id,Name");
                            astream.WriteLine("KnowledgeAreaId,Id,Name");
                            qstream.WriteLine("AreaId,Id,Weight,Level,Value,Name");
                            foreach (var p in Platforms)
                            {
                                pstream.WriteLine("{0},\"{1}\"", ++pc, p.Name);
                                foreach (var ka in p.KnowledgeArea)
                                {
                                    kastream.WriteLine("{0},{1},\"{2}\"", pc, ++kac, ka.Name);
                                    foreach (var a in ka.Area)
                                    {
                                        astream.WriteLine("{0},{1},\"{2}\"", kac, ++ac, a.Name);
                                        foreach (var q in a.Question)
                                        {
                                            qstream.WriteLine("{0},{1},{2},{3},{4},{5}", ac, ++qc, q.Weight, q.Level, q.Value, "");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        private void TransformInterviewDataToSQL()
        {
            var pc = 0;
            var kac = 0;
            var ac = 0;
            var qc = 0;
            using (var pstream = File.CreateText(
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "platforms.sql")))
            {
                using (var kastream = File.CreateText(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "knowledgeareas.sql")))
                {
                    using (var astream = File.CreateText(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "areas.sql")))
                    {
                        using (var qstream = File.CreateText(
                    Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "questions.sql")))
                        {
                            pstream.WriteLine("SET IDENTITY_INSERT [dbo].[Platforms] ON");
                            kastream.WriteLine("SET IDENTITY_INSERT [dbo].[KnowledgeAreas] ON");
                            astream.WriteLine("SET IDENTITY_INSERT [dbo].[Areas] ON");
                            qstream.WriteLine("SET IDENTITY_INSERT [dbo].[Questions] ON");
                            foreach (var p in Platforms)
                            {
                                pstream.WriteLine("insert into [Platforms] (Id,Name) values({0},N'{1}');", ++pc, p.Name);
                                foreach (var ka in p.KnowledgeArea)
                                {
                                    kastream.WriteLine("insert into [KnowledgeAreas] (PlatformId,Id,Name) values({0},{1},N'{2}');", pc, ++kac, ka.Name);
                                    foreach (var a in ka.Area)
                                    {
                                        astream.WriteLine("insert into [Areas] (KnowledgeAreaId,Id,Name) values({0},{1},N'{2}');", kac, ++ac, a.Name);
                                        foreach (var q in a.Question)
                                        {
                                            qstream.WriteLine("insert into [Questions] (AreaId,Id,Weight,Level,Value,Name) values({0},{1},{2},{3},N'{4}',N'{5}');", ac, ++qc, q.Weight, q.Level, q.Value, "");
                                        }
                                    }
                                }
                            }
                            pstream.WriteLine("SET IDENTITY_INSERT [dbo].[Platforms] OFF");
                            kastream.WriteLine("SET IDENTITY_INSERT [dbo].[KnowledgeAreas] OFF");
                            astream.WriteLine("SET IDENTITY_INSERT [dbo].[Areas] OFF");
                            qstream.WriteLine("SET IDENTITY_INSERT [dbo].[Questions] OFF");
                        }
                    }
                }
            }
        }

    }
}

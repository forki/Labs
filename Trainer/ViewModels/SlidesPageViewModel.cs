using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Template10.Mvvm;
using Template10.Services.NavigationService;
using Trainer.Domain;
using Windows.UI.Xaml.Navigation;
using Common;
using System;
using Log.Common.Services;
using Log.Common.Services.Common;
using System.Xml.Linq;

namespace Trainer.ViewModels
{
    public class SlidesPageViewModel : ViewModelBase
    {
        private readonly ICodeServices _codeServices;

        public SlidesPageViewModel()
        {
            if (Windows.ApplicationModel.DesignMode.DesignModeEnabled)
            {
            }

            _codeServices = new CodeServices();
            MainViewModel.ViewModel.GetPresentations((items) => Presentations = items);
        }

        private async void GetSlideMarkdown(Action<string> action)
        {
            using (var service = ApiServiceFactory.CreateService<string>(Services.SettingsServices.SettingsService.Instance.CodeServicesUrl, useJson: false))
            {
                var parser = ParserFactory.CreateSlideParser(service);
                var markDown = await parser.Parse(_currentSlide);
                if (!string.IsNullOrEmpty(markDown))
                {
                    markDown = XElement.Parse(markDown).Value;
                }
                if (action != null)
                {
                    
                    action.Invoke(markDown);
                }
            }
        }

        public string Foother
        {
            get { return string.Format("Slide {0} of {1}", Presentation.Slide.IndexOf(CurrentSlide) + 1, Presentation.Slide.Count); }
        }

        private ObservableCollection<Presentation> _presentations;
        public ObservableCollection<Presentation> Presentations
        {
            get
            {
                return _presentations;
            }

            private set
            {
                Set(ref _presentations, value);
                Presentation = string.IsNullOrEmpty(MainViewModel.ViewModel.SelectedPresentationTitle)
                    ? _presentations.FirstOrDefault()
                    : _presentations.FirstOrDefault(x => x.Title.Equals(MainViewModel.ViewModel.SelectedPresentationTitle));
            }
        }


        private Presentation _presentation;
        public Presentation Presentation
        {
            get
            {
                return _presentation;
            }
            private set
            {
                Set(ref _presentation, value);
                CurrentSlide = _presentation.Slide.FirstOrDefault();
            }
        }

        private Slide _currentSlide;
        public Slide CurrentSlide
        {
            get { return _currentSlide; }
            private set {
                Set(ref _currentSlide, value);
                if(null != _currentSlide && string.IsNullOrEmpty(_currentSlide.Markdown))
                {
                    GetSlideMarkdown((markDown) => _currentSlide.Markdown = markDown);
                }
            }
        }

        public string BackgroundImageUrl
        {
            get { return !string.IsNullOrEmpty(CurrentSlide.Image) ? CurrentSlide.Image : Presentation.Image; }
        }

        public override async Task OnNavigatedToAsync(object parameter, NavigationMode mode, IDictionary<string, object> suspensionState)
        {
            if(null != parameter)
            {
                if (parameter is string)
                {
                    CurrentSlide = _presentation.Slide.First(x => x.Title.Equals(parameter.ToString()));
                }
                else //is dynamic object
                {
                    Presentation = _presentations
                        .FirstOrDefault(x => x.Title.Equals(((dynamic)parameter).Title));
                }
            }

            await Task.CompletedTask;
        }

        public override async Task OnNavigatedFromAsync(IDictionary<string, object> suspensionState, bool suspending)
        {
            if (suspending)
            {
                suspensionState[nameof(CurrentSlide.Title)] = CurrentSlide.Title;
            }
            await Task.CompletedTask;
        }

        public override async Task OnNavigatingFromAsync(NavigatingEventArgs args)
        {
            args.Cancel = false;
            await Task.CompletedTask;
        }

        public void GotoNextSlide() =>
            NavigationService.Navigate(typeof(Views.SlidePage), GetNextSlideTitle());

        public void GotoPreviousSlide() =>
            NavigationService.Navigate(typeof(Views.SlidePage), GetPreviousSlideTitle());

        public void CopySlide() =>
            Presentation.Slide.Insert(Presentation.Slide.IndexOf(Presentation.Slide.First(x => x.Title.Equals(_currentSlide.Title))), Clone(_currentSlide));

        public void AddSlide() =>
            Presentation.Slide.Add(new Slide
            {
                Title = "Slide Title",
                Block = new ObservableCollection<RichTextBlock>
                {
                    new RichTextBlock
                    {
                        FontSize = 18,
                        FontWeight = "DemiBold",
                        LineHeight = 20
                    }
                }
            });

        public bool CanRemoveSlide { get { return Presentation.Slide.Count > 1; } }

        public void RemoveSlide() =>
            Presentation.Slide.Remove(Presentation.Slide.First(x => x.Title.Equals(_currentSlide.Title)));

        public bool CanGotoPreviousSlide { get { return !_currentSlide.Title.Equals(_presentation.Slide.First().Title); } }

        public bool CanGotoNextSlide { get { return !_currentSlide.Title.Equals(_presentation.Slide.Last().Title); } }

        private string GetNextSlideTitle()
        {
            var index = _presentation.Slide.IndexOf(_currentSlide);
            if(index < _presentation.Slide.Count-1)
            {
                return _presentation.Slide.ElementAt(index + 1).Title;
            }

            return _presentation.Slide.First().Title;
        }

        private string GetPreviousSlideTitle()
        {
            var index = _presentation.Slide.IndexOf(_currentSlide);
            if (index > 0)
            {
                return _presentation.Slide.ElementAt(index - 1).Title;
            }

            return _presentation.Slide.First().Title;
        }

        private Slide Clone(Slide source)
        {
            var xml = XmlHelper2<Slide>.Save(source);
            return XmlHelper2<Slide>.LoadFromString(xml);
        }
    }
}


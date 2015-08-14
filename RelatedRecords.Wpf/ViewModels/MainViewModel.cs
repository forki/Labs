﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Runtime.CompilerServices;
using RelatedRecords.Wpf.Annotations;
using System.Configuration;
using Common;
using System.Windows;
using System.Collections.ObjectModel;
using Serilog;

namespace RelatedRecords.Wpf.ViewModels
{
    public partial class MainViewModel : INotifyPropertyChanged
    {
        public MainViewModel()
        {
            var configuration = ConfigurationManager.AppSettings["ConfigurationFile"];
            TraceLog.Information("Running with {configuration} file", configuration);

            SelectedConfiguration = XmlHelper<CConfiguration>.Load(configuration);
        }

        private static MainViewModel _instance = new MainViewModel();
        public static MainViewModel ViewModel {
            get { return _instance; }
        }

        #region Events

        public delegate void QueryingTableCompleted(object sender, EventArgs e);
        public event QueryingTableCompleted OnQueryingTableCompleted;

        public delegate void Connect(object sender, EventArgs e);
        public event Connect OnConnect;

        public delegate void ProgressNotify(string message);
        public event ProgressNotify OnProgressNotify;

        public delegate void ExportCompleted(string fileName);
        public event ExportCompleted OnExportCompleted;

        private Action<int> onProgress;
        private Action<string> onNotify;

        #endregion //Events

        public ILogger TraceLog
        {
            get { return Common.Extensions.TraceLog; }
        }

        public ILogger ErrorLog
        {
            get { return Common.Extensions.ErrorLog; }
        }

        public CConfiguration SelectedConfiguration
        {
            get { return Extensions.SelectedConfiguration; }
            set
            {
                Extensions.SelectedConfiguration = value;
                OnPropertyChanged();
                Extensions.MaxRowCount = MaxRowCount;
            }
        }

        public CDataset SelectedDataset
        {
            get { return Extensions.SelectedDataset; }
            set
            {
                Extensions.SelectedDataset = value;
                OnPropertyChanged();
            }
        }

        public CDatasource SelectedDatasource
        {
            get { return Extensions.SelectedDatasource; }
            set
            {
                Extensions.SelectedDatasource = value;
                OnPropertyChanged();
            }
        }        

        private ObservableCollection<DatatableEx> _dataTablesList;
        public ObservableCollection<DatatableEx> DataTablesList
        {
            get
            {
                if(null == _dataTablesList)
                {
                    Common.Extensions.TraceLog.Information("Loading Data Tables List @ DataTablesList");
                    _dataTablesList = new ObservableCollection<DatatableEx>(
                        from ds in SelectedConfiguration.Dataset
                        select ds.Table.First(x => x.name == ds.defaultTable)
                            .Query("".ToArray(""), 
                            "".ToArray(""), 
                            SelectedConfiguration.Datasource
                                .First(x => x.name == ds.dataSourceName).ConnectionString, 
                            true)
                    );

                    OnPropertyChanged();
                    SelectedDataTable = _dataTablesList.First();
                }

                return _dataTablesList;
            }
        }

        private DatatableEx _selectedDataTable;
        public DatatableEx SelectedDataTable
        {
            get { return _selectedDataTable; }
            set
            {
                if (_selectedDataTable != value)
                {
                    _selectedDataTable = value;
                    OnPropertyChanged();
                    SelectedRootDataView = _selectedDataTable.Root.Table.AsDataView();
                    if (_selectedDataTable.Root.Table.Rows.Count > 0)
                    {
                        SelectedRootDataRowView = SelectedRootDataView[0];
                    }
                    OnPropertyChanged("ParentVisibility");
                    _goBackCommand.RaiseCanExecuteChanged();
                }
            }
        }

        private DataRowView _selectedRootDataRowView;
        public DataRowView SelectedRootDataRowView
        {
            get { return _selectedRootDataRowView; }
            set
            {
                if (!value.AreEqual(_selectedRootDataRowView))
                {
                    _selectedRootDataRowView = value;
                    OnPropertyChanged();

                    if (null != _selectedRootDataRowView)
                    {
                        Common.Extensions.TraceLog.Information("Loading Children tables @ SelectedRootDataRowView");
                        SelectedDataTable.QueryChildren(_selectedRootDataRowView.Row, SelectedDatasource.ConnectionString);
                    }
                }
            }
        }

        private DataView _selectedRootDataView;
        public DataView SelectedRootDataView
        {
            get { return _selectedRootDataView; }
            set
            {
                _selectedRootDataView = value;
                OnPropertyChanged();
            }
        }

        private string _selectedConnectionString;
        public string SelectedConnectionString
        {
            get { return _selectedConnectionString; }
            set
            {
                _selectedConnectionString = value;
                OnPropertyChanged();
            }
        }

        private CConfiguration _selectedNewConfiguration;
        public CConfiguration SelectedNewConfiguration
        {
            get { return _selectedNewConfiguration; }
            set
            {
                _selectedNewConfiguration = value;
                OnPropertyChanged();
                OnPropertyChanged("SelectedNewConfigurationTables");
                _saveDatasourceSchemaCommand.RaiseCanExecuteChanged();
            }
        }

        public ObservableCollection<CTable> SelectedNewConfigurationTables
        {
            get
            {
                if(null != _selectedNewConfiguration)
                {
                    return new ObservableCollection<CTable>(
                        from t in _selectedNewConfiguration.Dataset.First().Table
                           select t);
                }

                return new ObservableCollection<CTable>();
            }
        }

        private Stack<DatatableEx> _tableNavigation = new Stack<DatatableEx>();
        public Stack<DatatableEx> TableNavigation
        {
            get { return _tableNavigation; }
        }

        public Visibility ParentVisibility
        {
            get { return TableNavigation.Count > 0 ? Visibility.Visible : Visibility.Collapsed;  }
        }

        public string CacheFile { get; set; }

        private int _loadProgress = 0;
        public int LoadProgress
        {
            get { return _loadProgress; }
            private set
            {
                //if (loadProgress == value) return;
                _loadProgress = value;
                OnPropertyChanged("LoadProgress");

                if (null != OnProgressNotify)
                    OnProgressNotify(string.Format("{0} %", _loadProgress));
            }
        }

        private void OnReportProgress(int progressPercentage)
        {
            this.LoadProgress = progressPercentage;
        }

        private ObservableCollection<string> _lastErrors = new ObservableCollection<string>();
        public ObservableCollection<string> LastErrors
        {
            get { return _lastErrors; }
        }

        private bool _isBusy = false;
        public bool IsBusy
        {
            get { return _isBusy; }
            set
            {
                if (_isBusy == value) return;
                _isBusy = value;
                OnPropertyChanged("IsBusy");
                OnPropertyChanged("SprocketVisibility");
            }
        }

        public Properties.Settings AppSettings
        {
            get { return Properties.Settings.Default; }
        }

        public Visibility SprocketVisibility
        {
            get { return (this.IsBusy ? Visibility.Visible : Visibility.Collapsed); }
        }

        public Visibility LastErrorsVisibility
        {
            get { return (LastErrors.Count > 0 ? Visibility.Visible : Visibility.Collapsed); }
        }

        #region property changed handler

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        #endregion property changed handler
    }
}

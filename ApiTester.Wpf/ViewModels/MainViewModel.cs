﻿using ApiTester.Models;
using Common;
using FluentTesting;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Windows;
using System.Windows.Controls;
using Common.Commands;

namespace ApiTester.Wpf.ViewModels
{
    public partial class MainViewModel: BaseModel
    {
        private static MainViewModel _viewModel = new MainViewModel();
        public static MainViewModel ViewModel {
            get { return _viewModel; }
        }

        public MainViewModel()
        {
            //OnPropertyChanged("Configurations");
        }

        private Dictionary<string, Assembly> _assemblies = new Dictionary<string, Assembly>();
        private Dictionary<string, Type> _assemblyTypes = new Dictionary<string, Type>();

        private void SaveConfigurationWorkflow()
        {
            if (null != EditingWorkflow)
            {
                var file = Path.Combine(ConfigurationManager.AppSettings["ConfigurationPath"],
                     SelectedWorkflow.name);
                if (File.Exists(file))
                    File.Delete(file);
                XmlHelper<workflow>.Save(file, EditingWorkflow);
            }
        }

        private void SaveConfiguration()
        {
            if (null != SelectedConfiguration)
            {
                var file = Path.Combine(ConfigurationManager.AppSettings["ConfigurationPath"],
                     SelectedConfiguration.setup.name.Split('.').Last()
                     .Replace("Controller", string.Empty) + "-apitester.xml");
                if (File.Exists(file))
                    File.Delete(file);
                XmlHelper<apiConfiguration>.Save(file, SelectedConfiguration);
            }
        }

        private void SaveWorkflowItem(workflow workflow)
        {
            var file = Path.Combine(ConfigurationManager.AppSettings["ConfigurationPath"],
                 workflow.name);
            if (File.Exists(file))
                File.Delete(file);
            XmlHelper<workflow>.Save(file, workflow);
        }

        public IEnumerable<apiConfiguration> Configurations
        {
            get
            {
                var files = Directory.GetFiles(ConfigurationManager.AppSettings["ConfigurationPath"], "*.xml")
                    .Where(f => f.EndsWith("apitester.xml"));
                var list = new List<apiConfiguration>();
                
                foreach(var file in files)
                {
                    var configuration = XmlHelper<apiConfiguration>.Load(file);
                    if(!list.Any(x => x.ToString() == configuration.ToString()))
                        list.Add(configuration);
                }

                SelectedConfiguration = list.FirstOrDefault();

                return list;
            }
        }

        private apiConfiguration _selectedConfiguration;
        public apiConfiguration SelectedConfiguration
        {
            get { return _selectedConfiguration; }
            set
            {
                _selectedConfiguration = value;
                if (_selectedConfiguration != null)
                {
                    SelectedHost = _selectedConfiguration.setup.host.FirstOrDefault();
                    SelectedWorkflow = _selectedConfiguration.setup.workflow.FirstOrDefault();
                    SelectedMethod = _selectedConfiguration.method.FirstOrDefault();
                    if(!_assemblies.ContainsKey(_selectedConfiguration.setup.source))
                    {
                        loadAssembly(_selectedConfiguration.setup.source);
                        foreach(var asm in _selectedConfiguration.assembly)
                        {
                            loadAssembly(asm.name);
                        }
                    }

                    if (string.IsNullOrEmpty(DocumentationPath))
                    {
                        var ofd = new OpenFileDialog
                        {
                            Title = "Select a Swagger File",
                            CheckFileExists = true,
                            DefaultExt = "yaml",
                            InitialDirectory = AppDomain.CurrentDomain.BaseDirectory,
                            Multiselect = false,
                            Filter = "Swagger Files|*.yaml"
                        };
                        if (ofd.ShowDialog().Value)
                        {
                            DocumentationPath = Path.GetDirectoryName(ofd.FileName);
                        }
                    }

                    if (!string.IsNullOrEmpty(DocumentationPath))
                    {
                        if (Directory.Exists(DocumentationPath))
                        {
                            try {
                                var swaggerProjectFile = Path.Combine(DocumentationPath, "swagger.yaml");
                                var swaggerDefPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                    ConfigurationManager.AppSettings["ConfigurationPath"]);
                                var swaggerFile = Path.Combine(swaggerDefPath,
                                   _selectedConfiguration.setup
                                    .name.Split('.').Last().Replace("Controller", string.Empty)
                                    + "-swagger.yaml");
                                if (File.Exists(swaggerFile))
                                {
                                    if (File.Exists(swaggerProjectFile)) File.Delete(swaggerProjectFile);

                                    File.Copy(swaggerFile, swaggerProjectFile);
                                }
                            } catch(Exception) {; }
                        }
                    }
                    OnPropertyChanged();
                    OnPropertyChanged("HeadersTable");
                    OnPropertyChanged("MethodsTable");
                    RunTests.AsRelay().RaiseCanExecuteChanged();
                    RunWorkflowTests.AsRelay().RaiseCanExecuteChanged();
                }
            }
        }

        private void loadAssembly(string source)
        {
            if (!_assemblies.ContainsKey(source))
            {
                var asm = getAssembly(source);

                if (null != asm)
                    _assemblies.Add(source, asm);
            }
        }

        private Assembly getAssembly(string source)
        {
            try {
                return Assembly.LoadFrom(source);
            } catch(Exception e)
            {
                Common.Extensions.ErrorLog.Error(e, "@ getAssembly {source}", source);
                return null;
            }
        }

        public DataTable HeadersTable
        {
            get
            {
                var table = new DataTable("Headers");
                table.Columns.Add(new DataColumn("Name", typeof(string)));
                table.Columns.Add(new DataColumn("Value", typeof(string)));

                if (SelectedConfiguration == null) return table;

                foreach(var h in SelectedConfiguration.setup.header)
                {
                    var row = table.NewRow();
                    row["Name"] = h.name;
                    row["Value"] = h.value;
                    table.Rows.Add(row);
                }

                foreach (var h in SelectedHost.header)
                {
                    var row = table.NewRow();
                    row["Name"] = h.name;
                    row["Value"] = h.value;
                    table.Rows.Add(row);
                }


                var headers = from h in SelectedConfiguration.setup.header
                              from bh in h.buildHeader
                              where bh != null && string.IsNullOrEmpty(h.value)
                              select h;
                foreach (var h in headers)
                {
                    foreach (var bh in h.buildHeader)
                    {
                        table.Rows.Add(buildHeaderRow(bh, table));
                    }
                }

                return table;
            }
        }

        private DataRow buildHeaderRow(BuildHeader header, DataTable table)
        {
            var row = table.NewRow();
            foreach(var t in header.workflow)
            {        
                //todo: build actual header value from tasks        
            }

            row["Name"] = header.name;
            row["Value"] = "?";
            return row;
        }

        public DataTable MethodsTable
        {
            get { return SelectedConfiguration.ToTable(); }
        }

        public DataTable ResultsTable
        {
            get { return null != ExecutedWorkflow ? ExecutedWorkflow.ToTable() : null; }
        }

        private DataRowView _selectedDataRowView;
        public DataRowView SelectedDataRowView
        {
            get { return _selectedDataRowView; }
            set
            {
                _selectedDataRowView = value;
                OnPropertyChanged();
                if(null != _selectedDataRowView)
                {
                    SelectedMethod = SelectedConfiguration.method
                        .First(x => x.name == _selectedDataRowView["name"].ToString());
                }
            }
        }

        private Method _selectedMethod;
        public Method SelectedMethod
        {
            get { return _selectedMethod; }
            set {
                _selectedMethod = value;
                OnPropertyChanged();
                OnPropertyChanged("ParametersTable");
                AddTask.AsRelay().RaiseCanExecuteChanged();
            }
        }

        public DataTable ParametersTable
        {
            get {
                if(null != SelectedMethod && SelectedMethod.parameter.Any())
                    return  SelectedMethod.ToTable();

                return null;
            }
        }

        private Host _selectedHost;
        public Host SelectedHost
        {
            get { return _selectedHost; }
            set
            {
                _selectedHost = value;
                OnPropertyChanged();
                OnPropertyChanged("HeadersTable");
            }
        }

        private DataRowView _selectedWorkflowDataRowView;
        public DataRowView SelectedWorkflowDataRowView
        {
            get { return _selectedWorkflowDataRowView; }
            set
            {
                _selectedWorkflowDataRowView = value;
                OnPropertyChanged();
                if (null != _selectedWorkflowDataRowView)
                {
                    SelectedWorkflowTask = _editingWorkflow.task
                        .First(x => x.name == _selectedWorkflowDataRowView["name"].ToString());
                }
            }
        }

        private Models.Task _selectedWorkflowTask;
        public Models.Task SelectedWorkflowTask
        {
            get { return _selectedWorkflowTask; }
            set
            {
                _selectedWorkflowTask = value;
                OnPropertyChanged();
                OnPropertyChanged("WorkflowParametersTable");
                OnPropertyChanged("WorkflowResultsTable");
                WorkflowResultsTable = null;
                WorkflowParametersTable = null;
                _saveWorkflow.RaiseCanExecuteChanged();
            }

        }

        private workflow _editingWorkflow;
        public workflow EditingWorkflow
        {
            get { return _editingWorkflow; }
            set
            {
                _editingWorkflow = value;
                OnPropertyChanged();
            }
        }

        public DataTable WorkflowTable
        {
            get {
                if (null != SelectedWorkflow)
                {
                    if (null == EditingWorkflow)
                    {
                        EditingWorkflow = XmlHelper<workflow>.Load(
                            Path.Combine(
                                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "output"),
                                SelectedWorkflow.name));
                    }

                    return EditingWorkflow.ToTable(isEdit: true);
                }
                return null;
            }
        }

        private DataTable _workflowParametersTable;
        public DataTable WorkflowParametersTable
        {
            get
            {
                if (null != SelectedWorkflow)
                {
                    if (null == _workflowParametersTable)
                    {
                        _workflowParametersTable = SelectedWorkflowTask.ToTable();
                    }
                    return _workflowParametersTable;
                }

                return null;
            }
            set
            {
                _workflowParametersTable = value;
                OnPropertyChanged();
            }
        }

        private DataTable _workflowResultsTable;
        public DataTable WorkflowResultsTable
        {
            get
            {
                if (null != SelectedWorkflow)
                {
                    if (null == _workflowResultsTable)
                    {
                        _workflowResultsTable = SelectedWorkflowTask.ToTable(isParameter: false);
                    }
                    return _workflowResultsTable;
                }
                return null;
            }
            set
            {
                _workflowResultsTable = value;
                OnPropertyChanged();
            }
        }

        private workflow _selectedWorkflow;
        public workflow SelectedWorkflow
        {
            get { return _selectedWorkflow; }
            set
            {
                _selectedWorkflow = value;
                OnPropertyChanged();
                SelectedWorkflowDef = value;
            }
        }

        private List<workflow> _workflowDefs = new List<workflow>();
        private workflow _selectedWorkflowDef;
        public workflow SelectedWorkflowDef
        {
            get { return _selectedWorkflowDef; } 
            set
            {
                if (null != value)
                {
                    var workflow = _workflowDefs.FirstOrDefault(x => x.name.Equals(value.name));
                    if(workflow == null)
                    {
                        _workflowDefs.Add(
                            XmlHelper<workflow>.Load(
                                Path.Combine(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "output"), value.name)));
                        workflow = _workflowDefs.Last();
                    }

                    _selectedWorkflowDef = workflow;
                }
                OnPropertyChanged();
            }
        }

        private buildWorkflow _selectedBuildWorkflow;
        public buildWorkflow SelectedBuildWorkflow
        {
            get { return _selectedBuildWorkflow; }
            set
            {
                _selectedBuildWorkflow = value;
                OnPropertyChanged();
            }
        }

        public string BinariesPath
        {
            get { return Properties.Settings.Default.BinariesPath; }
            set
            {
                if (Properties.Settings.Default.BinariesPath == value) return;
                Properties.Settings.Default.BinariesPath = value;
                Properties.Settings.Default.Save();
                OnPropertyChanged();
            }
        }

        public string DocumentationPath
        {
            get { return Properties.Settings.Default.DocumentationPath; }
            set
            {
                if (Properties.Settings.Default.DocumentationPath == value) return;
                Properties.Settings.Default.DocumentationPath = value;
                Properties.Settings.Default.Save();
                OnPropertyChanged();
            }
        }

        private List<Assembly> _availableAssemblies;
        public IEnumerable<Assembly> AvailableAssemblies
        {
            get
            {
                var list = _availableAssemblies;

                if (null == list)
                {
                    _availableAssemblies = new List<Assembly>();

                    if(string.IsNullOrEmpty(BinariesPath))
                    {
                        var ofd = new OpenFileDialog
                        {
                            Title = "Select a File Assembly",
                            CheckFileExists = true,
                            DefaultExt = "dll",
                            InitialDirectory = AppDomain.CurrentDomain.BaseDirectory,
                            Multiselect = false,
                            Filter = "Assembly Files|*.dll"
                        };
                        if(ofd.ShowDialog().Value)
                        {
                            BinariesPath = Path.GetDirectoryName(ofd.FileName);
                        }
                        else
                        {
                            return _availableAssemblies;
                        }
                    }

                    foreach (var file in Directory.GetFiles(BinariesPath, "*.dll"))
                    {
                        var asm = getAssembly(file);
                        if (null != asm)
                        {
                            _availableAssemblies.Add(asm);
                        }
                    }

                    list = _availableAssemblies;

                } else if (!string.IsNullOrEmpty(FilterAssemblies))
                {
                    list = _availableAssemblies
                        .Where(x => x.Location.ToLower().Contains(FilterAssemblies.ToLower().Trim()))
                        .ToList();
                }

                SelectedAssembly = list.FirstOrDefault();

                return list;
            }
        }

        private Assembly _selectedAssembly;
        public Assembly SelectedAssembly
        {
            get { return _selectedAssembly; }
            set
            {
                _selectedAssembly = value;
                OnPropertyChanged();
                OnPropertyChanged("AvailableTypes");
            }
        }

        public IEnumerable<Type> AvailableTypes
        {
            get
            {
                if (null != SelectedAssembly)
                {
                    var types = SelectedAssembly.GetTypes().Where(x => x.Name.Contains("Controller"));
                    SelectedType = types.FirstOrDefault();
                    return types;
                }

                return null;
            }
        }

        private Type _selectedType;
        public Type SelectedType
        {
            get { return _selectedType; }
            set
            {
                _selectedType = value;
                OnPropertyChanged();
                OnPropertyChanged("AvailableMethods");
                //_loadConfiguration.RaiseCanExecuteChanged();
            }
        }

        private IEnumerable<Type> _selectedTypes;
        public IEnumerable<Type> SelectedTypes
        {
            get { return _selectedTypes; }
            set
            {
                _selectedTypes = value;
                OnPropertyChanged();
            }
        }

        public IEnumerable<MethodInfo> AvailableMethods
        {
            get {
                if(null != SelectedType)
                {
                    return SelectedType.GetMethods();
                }

                return null;
            }
        }

        private string _filterAssemblies;
        public string FilterAssemblies
        {
            get { return _filterAssemblies; }
            set
            {
                _filterAssemblies = value;
                OnPropertyChanged();
                OnPropertyChanged("AvailableAssemblies");
            }
        }

        private ObservableCollection<string> _lastErrors = new ObservableCollection<string>();
        public ObservableCollection<string> LastErrors
        {
            get { return _lastErrors; }
        }

        public string LastErrorsString
        {
            get { return string.Join(". ", LastErrors.ToArray()); }
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

        public Visibility SprocketVisibility
        {
            get { return (this.IsBusy ? Visibility.Visible : Visibility.Collapsed); }
        }

        public Visibility LastErrorsVisibility
        {
            get { return (LastErrors.Count > 0 ? Visibility.Visible : Visibility.Collapsed); }
        }

        private workflow _executedWorkflow;
        public workflow ExecutedWorkflow
        {
            get { return _executedWorkflow; }
            set
            {
                _executedWorkflow = value;
                OnPropertyChanged();
                OnPropertyChanged("ResultsVisibility");
                OnPropertyChanged("ResultsTable");
            }
        }

        public Visibility ResultsVisibility
        {
            get { return null != ExecutedWorkflow ? Visibility.Visible: Visibility.Collapsed; }
        }

        private TabItem _selectedTabItem;
        public TabItem SelectedTabItem
        {
            get { return _selectedTabItem; }
            set
            {
                _selectedTabItem = value;
                OnPropertyChanged();
            }
        }

        private bool IsNotEditingWorkflow
        {
            get { return !_isEditingWorkflow; }
        }

        private bool _isEditingWorkflow;
        public bool isEditingWorkflow
        {
            get { return _isEditingWorkflow; }
            set
            {
                _isEditingWorkflow = value;
                OnPropertyChanged();
                OnPropertyChanged("EditWorkflowVisibility");
                OnPropertyChanged("IsNotEditingWorkflow");

                if(_isEditingWorkflow)
                    OnPropertyChanged("WorkflowTable");
            }
        }

        public Visibility EditWorkflowVisibility
        {
            get { return isEditingWorkflow ? Visibility.Visible : Visibility.Collapsed; }
        }

        public IEnumerable<eCondition> Conditions
        {
            get { return typeof(eCondition).GetEnumValues().Cast<eCondition>(); }
        }

        public IEnumerable<eOperator> Operators
        {
            get { return typeof(eOperator).GetEnumValues().Cast<eOperator>(); }
        }
    }
}

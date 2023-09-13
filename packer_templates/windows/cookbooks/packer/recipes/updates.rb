#
# Updating this file:
# Go to: https://www.catalog.update.microsoft.com/
# Type in the knowledge base (KB) number, e.g. KB5005112 into the search
# Click on the appropriate title in the list and view the Package Details tab.
# Look for newer versions and click through.
# Search for the newer KB number and click download to get the URL and title.
#
if windows_nt_version == '10.0.17763' # 2019
  msu_package '2021-08 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB5005112)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/08/windows10.0-kb5005112-x64_81d09dc6978520e1a6d44b3b15567667f83eba2c.msu'
    action :install
  end
  # This is basically a service pack and we should install it to fix a giant pile of bugs
  msu_package '2023-08 Cumulative Update for Windows Server 2019 for x64-based Systems (KB5029247)' do
    source 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2023/08/windows10.0-kb5029247-x64_9894baa6db2836dc3ddea322bc3128b8653005fc.msu'
    action :install
    timeout 7200
  end
elsif windows_nt_version == '10.0.14393' # 2016
  msu_package '2023-03 Servicing Stack Update for Windows 10 Version 1607 for x64-based Systems (KB5023788)' do
    source 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/03/windows10.0-kb5023788-x64_33ea5888c89d2888b845cf02e8d3950d13d1d1f9.msu'
    action :install
    timeout 7200
  end
  # This is basically a service pack and we should install it to fix a giant pile of bugs
  msu_package '2023-08 Cumulative Update for Windows Server 2016 for x64-based Systems (KB5029242)' do
    source 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2023/08/windows10.0-kb5029242-x64_de925ba31c7c1e38ce8b97da441784d2276d26b1.msu'
    action :install
    timeout 7200
  end
elsif windows_nt_version == '6.3.9600' # 2012r2
  msu_package 'Windows Management Framework 5.1 for 2012r2' do
    source 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu'
    action :install
  end
  msu_package '2023-08 Servicing Stack Update for Windows Server 2012 R2 for x64-based Systems (KB5029368)' do
    source 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2023/07/windows8.1-kb5029368-x64_2afab9a8d12ca38305c593ed3cbb7b077885aebd.msu'
    action :install
  end
  msu_package '2022-11 Security Monthly Quality Rollup for Windows Server 2012 R2 for x64-based Systems (KB5020023)' do
    source 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2022/11/windows8.1-kb5020023-x64_bac631bd04b0ed264983ca415368a38aff5e323f.msu'
    action :install
  end
elsif windows_nt_version == '6.2.9200' # 2012
  msu_package 'Windows Management Framework 5.1' do
    source 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/W2K12-KB3191565-x64.msu'
    action :install
  end
  msu_package '2017-05 Update for Windows Server 2012 (KB4019990)' do
    source 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2017/05/windows8-rt-kb4019990-x64_a77f4e3e1f2d47205824763e7121bb11979c2716.msu'
    action :install
  end
  msu_package '2021-04 Servicing Stack Update for Windows Server 2012 for x64-based Systems (KB5001401)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/04/windows8-rt-kb5001401-x64_1027ae2c9888c2dfe0caadeafc506b3012789c56.msu'
    action :install
  end
  msu_package '2020-10 Security and Quality Rollup for .NET Framework 3.5 for Windows Server 2012 for x64 (KB4578950)' do # Only apply the 3.5 Framework update.
    source 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2020/10/windows8-rt-kb4578950-x64_244ebe93eeb1e31b0faf966d86e99ca70232cf5e.msu'
    action :install
  end
  msu_package '2021-10 Security Monthly Quality Rollup for Windows Server 2012 for x64-based Systems (KB5006739)' do
    source 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2021/10/windows8-rt-kb5006739-x64_3d984253b421c404b2fbd71ba5728c2194774142.msu'
    action :install
  end
elsif windows_nt_version == '6.1.7600' or windows_nt_version == '6.1.7601' # 2008 R2
  remote_file 'WMF 5.1 download' do
    source 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win7AndW2K8R2-KB3191566-x64.zip'
    path "#{Chef::Config[:file_cache_path]}/wmf5.1.zip"
  end
  archive_file "Extract WMF 5.1" do
    path "#{Chef::Config[:file_cache_path]}/wmf5.1.zip"
    destination "#{Chef::Config[:file_cache_path]}/wmf5.1"
    overwrite true
    action :extract
  end
  powershell_script do
    code <<-EOH
      . "#{Chef::Config[:file_cache_path]}/wmf5.1/Install-WMF5.1.ps1"
    EOH
  end
end
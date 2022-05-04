if windows_nt_version == '10.0.17763' # 2019
  msu_package '2021-08 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB5005112)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/08/windows10.0-kb5005112-x64_81d09dc6978520e1a6d44b3b15567667f83eba2c.msu'
    action :install
  end
  # This is basically a service pack and we should install it to fix a giant pile of bugs
  msu_package '2022-03 Cumulative Update for Windows Server 2019 for x64-based Systems (KB5011503)' do
    source 'https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/secu/2022/03/windows10.0-kb5011503-x64_4ffdd7a077a2c94d093a445f7a0efa10e0b92d95.msu'
    action :install
    timeout 7200
  end
elsif windows_nt_version == '10.0.14393' # 2016
  msu_package '2022-03 Servicing Stack Update for Windows Server 2016 for x64-based Systems (KB5011570)' do
    source 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2022/02/windows10.0-kb5011570-x64_5158690215f1809f8d15e13f49f576c549219fdf.msu'
    action :install
    timeout 7200
  end
  # This is basically a service pack and we should install it to fix a giant pile of bugs
  msu_package '2022-03 Cumulative Update for Windows Server 2016 for x64-based Systems (KB5011495)' do
    source 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2022/03/windows10.0-kb5011495-x64_5687d125f32cb1b43ad1c2dafb6d159b47f4d9bd.msu'
    action :install
    timeout 7200
  end
elsif windows_nt_version == '6.3.9600' # 2012r2
  msu_package 'Windows Management Framework 5.1 for 2012r2' do
    source 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu'
    action :install
  end
  msu_package '2021-04 Servicing Stack Update for Windows Server 2012 R2 for x64-based Systems (KB5001403)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/04/windows8.1-kb5001403-x64_7f15c4b281f38d43475abb785a32dbaf0355bad5.msu'
    action :install
  end
  msu_package '2022-02 Security and Quality Rollup for .NET Framework 3.5 for Windows Server 2012 R2 for x64 (KB5010583)' do
    source 'https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2021/12/windows8.1-kb5008868-x64_2bba90c33e85a3bc1b1f83de38937a0c79729646.msu'
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
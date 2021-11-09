if windows_nt_version == '10.0.17763' # 2019
  msu_package '2021-08 Servicing Stack Update for Windows Server 2019 for x64-based Systems (KB5005112)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/08/windows10.0-kb5005112-x64_81d09dc6978520e1a6d44b3b15567667f83eba2c.msu'
    action :install
  end
  # This is basically a service pack and we should install it to fix a giant pile of bugs
  msu_package '2021-10 Cumulative Update for Windows Server 2019 for x64-based Systems (KB5006672)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/10/windows10.0-kb5006672-x64_7044166433a0a9e2ffefe7608ad7d1fe05383c81.msu'
    action :install
    timeout 7200
  end
#  msu_package '2021-10 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windows Server 2019 for x64 (KB5006765) #1' do
#    source 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/08/windows10.0-kb5005540-x64-ndp48_ddca726ba3efa8935b549d9840b190c5efd78d60.msu'
#    action :install
#  end
#  msu_package '2021-10 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windows Server 2019 for x64 (KB5006765) #2' do
#    source 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2021/08/windows10.0-kb5005543-x64_3e4279f36b9b94cafb301f105e402b9d8df476bc.msu'
#    action :install
#  end
elsif windows_nt_version == '10.0.14393' # 2016
  msu_package '2021-09 Servicing Stack Update for Windows Server 2016 for x64-based Systems (KB5005698)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/09/windows10.0-kb5005698-x64_ff882b0a9dccc0c3f52673ba3ecf4a2a3b2386ca.msu'
    action :install
  end
  # This is basically a service pack and we should install it to fix a giant pile of bugs
  msu_package '2021-10 Cumulative Update for Windows Server 2016 for x64-based Systems (KB5006669)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/10/windows10.0-kb5006669-x64_aa5c931de237226eae4f333915750dbd998a8534.msu'
    action :install
    timeout 7200
  end
  #msu_package '2021-10 Cumulative Update for .NET Framework 4.8 for Windows Server 2016 for x64 (KB5006065)' do
  #  source 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2021/09/windows10.0-kb5006065-x64-ndp48_022b43043c63f17a102acfbbd06870b1bc3c45a6.msu'
  #  action :install
  #end
elsif windows_nt_version == '6.3.9600' # 2012r2
  msu_package 'Windows Management Framework 5.1 for 2012r2' do
    source 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu'
    action :install
  end
  msu_package '2021-04 Servicing Stack Update for Windows Server 2012 R2 for x64-based Systems (KB5001403)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2021/04/windows8.1-kb5001403-x64_7f15c4b281f38d43475abb785a32dbaf0355bad5.msu'
    action :install
  end
#  msu_package '2021-09 Security Monthly Quality Rollup for Windows Server 2012 for x64-based Systems (KB5005623)' do
#    source 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2021/09/windows8-rt-kb5005623-x64_27657b7dd5e80d8d99219b501e2bc3d13197b980.msu'
#    action :install
#  end
  msu_package '2020-10 Security and Quality Rollup for .NET Framework 3.5 for Windows 8.1 and Server 2012 R2 for x64 (KB4578953)' do
    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows8.1-kb4578953-x64_a69c4f610be6fcb6ff81d6668314c833f14cfed1.msu'
    action :install
  end
#  msu_package '2020-10 Security and Quality Rollup for .NET Framework 4.5.2 for Windows 8.1 and Server 2012 R2 for x64 (KB4578956)' do
#    source 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2020/10/windows8.1-kb4578956-x64_dda3af4d84bf29cdfb666a7bede3324632d445af.msu'
#    action :install
#  end
#  msu_package '2021-10 Security and Quality Rollup for .NET Framework 4.6, 4.6.1, 4.6.2, 4.7, 4.7.1, 4.7.2 for Windows Server 2012 R2 for x64 (KB5006064)' do
#    source 'http://download.windowsupdate.com/c/msdownload/update/software/updt/2021/09/windows8.1-kb5006064-x64_8f98a687a69abdd6d88c542db4b07f32a49d3ced.msu'
#    action :install
#  end
#  msu_package '2021-10 Security and Quality Rollup for .NET Framework 4.8 for Windows Server 2012 R2 for x64 (KB5006067)' do
#    source 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/09/windows8.1-kb5006067-x64-ndp48_ffc9fdca99bb63d693d2d17f23dcc4c166219247.msu'
#    action :install
#  end
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
  msu_package '2020-10 Security and Quality Rollup for .NET Framework 3.5 for Windows Server 2012 for x64 (KB4578950)' do
    source 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2020/10/windows8-rt-kb4578950-x64_244ebe93eeb1e31b0faf966d86e99ca70232cf5e.msu'
    action :install
  end
  msu_package '2021-10 Security Monthly Quality Rollup for Windows Server 2012 for x64-based Systems (KB5006739)' do
    source 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2021/10/windows8-rt-kb5006739-x64_3d984253b421c404b2fbd71ba5728c2194774142.msu'
    action :install
  end
  #msu_package '2020-10 Security and Quality Rollup for .NET Framework 4.5.2 for Windows Server 2012 for x64 (KB4578954)' do
  #  source 'http://download.windowsupdate.com/c/msdownload/update/software/secu/2020/10/windows8-rt-kb4578954-x64_293608e33d37d482f0ff670f5bfa7ef110548669.msu'
  #  action :install
  #end
  #msu_package '2021-10 Security and Quality Rollup for .NET Framework 4.6, 4.6.1, 4.6.2, 4.7, 4.7.1, 4.7.2 for Windows Server 2012 for x64 (KB5006063)' do
  #  source 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/09/windows8-rt-kb5006063-x64_ba496d1f7f7c45b5cdf66502e205f85bf906543e.msu'
  #  action :install
  #end
  #msu_package '2021-10 Security and Quality Rollup for .NET Framework 4.8 for Windows Server 2012 for x64 (KB5006066)' do
  #  source 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/09/windows8-rt-kb5006066-x64-ndp48_74d3dcec9f786610426195d9f12a4e0dc239bf2c.msu'
  #  action :install
  #end
end
#    windows_defender 'disable windows defender' do
#        action :disable
#    end

powershell_script 'disable windows defender' do
    code <<-EOH
        Get-WindowsFeature -Name 'Windows-Defender' | %{ if ($_.Installed) { Remove-WindowsFeature $_.Name } }
        Get-WindowsFeature -Name 'Windows-Defender-GUI' | %{ if ($_.Installed) { Remove-WindowsFeature $_.Name } }
    EOH
end

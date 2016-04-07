Puppet::Type.newtype(:choco_source) do
  desc "Puppet Type that models a Puppet Source configuration"
  
  #This States are possible
  ensurable do
    newvalue(:present) do
      provider.add
    end

    newvalue(:absent) do
      provider.remove
    end

    newvalue(:disabled) do
      provider.disable
    end
  end

  #Parameters
  newproperty(:name, :namevar => true) do
    desc "Name of the Chocolatey Source"
    #Validation ?
    defaultto "chocolatey"
  end

  newproperty(:source_url) do
    desc "Url to the Chocolatey Source"
    defaultto "https://chocolatey.org/api/v2/"
  end

  newproperty(:priority) do
    desc "Priority of the Source"
    newvalues(/^\d+$/)
  end

  newparam(:user) do
    desc "User for Source"
  end
  
  newparam(:password) do
    desc "Password for Source"
  end
end




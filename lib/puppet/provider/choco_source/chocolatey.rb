Puppet::Type.type(:choco_source).provide(:chocolatey) do

  commands :choco_source => 'choco source'
  
  def exists?

  end

  def add

  end

  def remove

  end

  def enable

  end

  def disable

  end

  def get_choco_sources_list
    begin
      output = choco_source(['list'])
    rescue Puppet::ExecutionFailure => e
      Puppet.debug("#get_choco_source list had an error -> #{e.inspect}"
      return nil
    end
    
    sources_raw = output.split("\n")
    return nil if ((sources_raw.first =~ /Chocolatey/) or sources_raw.to_s.empty?)
    sources_raw
  end

  def get_source_properties(name)
    source_property = {}
    
    if list = get_choco_sources_list()) == nil
      return nil
    end
    
    #Search for source in actualy available sources
    list.each do |source|
      if source.include? name
        source = source
      else
        source = nil
    end

    #Get name and possible Disabled Status    
    name = source.match /(.*)\-.*/
    name = name.split(" ")

    source_property[:name] = name[0]
    source_property[:enabled] = name[1].eql? nil

    #Get source URL and if there is authentication activated
    url = source.match /.*\-(.*)\|.*/
    url = url[1].split(" ")
     
    source_property[:url] = url[0]
    source_property[:auth]= !url[1].eql? nil

    #Get Priority
    prio = source.match /.*\|[a-zA-Z\ ]*(.*)\./ 

    source_property[:priority] = prio

    source_property
  end
end

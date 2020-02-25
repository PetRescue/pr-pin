Dir[SPEC_ROOT.join('support/representers/**/*.rb').to_s].each do |f|
  require f
end

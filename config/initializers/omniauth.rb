Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '118346668270845', '5bef5742c462d318de5d3774fb199e12'
end
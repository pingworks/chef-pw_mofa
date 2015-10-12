require_relative '../spec_helper'

describe command('sudo -H -u ubuntu bash -c "eval \$(chef shell-init bash); mofa 2>&1"') do
  its(:stdout) { should match /Commands:/ }
  its(:stdout) { should match /Options:/ }
end

describe command('sudo -H -u ubuntu bash -c "eval \$(chef shell-init bash); mofa version 2>&1"') do
  its(:stdout) { should match /0.2.*/ }
end

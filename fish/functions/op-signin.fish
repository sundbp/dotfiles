function op-signin
  set result (string match -r "export\s+(.*)\=\"(.*)\".*" (op signin $argv[1]))
  if test $status -ne 0
    echo "failed.."
    return
  else
    set -x $result[2] $result[3]
    echo "success!"
  end
end


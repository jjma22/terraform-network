# Terraform project

![A hero starting their journey looking at a tower](./media/images/journey.png "A hero starting their journey looking at a tower")

It is time to take those Terraform skills you have been developing and create your own project. 

Time to start your journey and create a brand new Terraform project from scratch. You know on the journey there will be challenges, that battle with your arch enemy "remote state", the boss fight of "sso authentication" but you are more than capable - you got this!

Side note: The image is what AI generated when the words "success, journey and terraform logo" were put into the tool 🤷

## Requirements

The target destination for this project is that you should be able to visit a website and see a HTML page that can be customised as much as you like but it should have the statement "Terraform Provisioned Me" somwhere on the page.

But that isn't everything....

We want this to be production ready so your solution should have

* Completed using terraform
* A production ready network setup with both public and private subnets
* Utilise remote state for storing the terraform state
* Make use of terraform variables and looping where required
* The HTML page must be served by back an NGINX web server
* The NGINX web server must reside within EC2 instances that are within the public subnet
* The NGINX web server should respond on port 80
* You should design for failure - we do not want a loss of service if one of the EC2 instances fails
* Be considerate and intentional of how your files and directory structures are named
* A comprehensive **INSTRUCTIONS.md** file that provide instructions on how to use the repository and how to get things working

Having to understand software that you might not have come across, such as NGINX in this scenario, is part of being a cloud engineer.  You will experience development teams creating apps in all different languages and approaches - you have to work out how to get them deployed so this exercise is the perfect preparation to try and work that out.

## Tearing things down

You should run `terraform destroy` to remove everything.

**🗒️ Note:** When using remote state sometimes the terraform destroy has a problem trying to remove your S3 bucket and DynamoDB table. if you experience this issue you can manually delete them using the AWS console.

## Submission process

1. Fork this GitHub repository

2. Make regular commits and pushes back to your repository as you write your code. It help us to see the journey you worked through when completing the task.
    
3. Share your GitHub link

4. Tear things down as described above


## Further reading

[NGINX Homepage](https://www.nginx.com/)

[Terraform directory structure tips](https://xebia.com/blog/four-tips-to-better-structure-terraform-projects/)

[Terraform best practices structure](https://www.terraform-best-practices.com/examples/terraform)

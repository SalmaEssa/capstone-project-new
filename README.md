## Axon Customer Project

<h3>Why This Project?</h3>

Axon is a commercial platform that serves millions of customers in the Egyptian market. It has been built by AKWAD developers on two cross-platform mobile clients using <b>FLUTTER</b> and a multi technology server side including <b>PHP</b>, <b>Node JS</b>, ...etc.

In this Capstone Project we added a good portion of Axon staging code to help our potential developers prove themselves on an -up and running- product instead of the classical interview questions that target the online tutorials plain knowledge. <b>It's a great opportunity to show an instant impact!</b>

<h3>What is this Project?</h3>
The capstone project consists of some modules and parts. Some you should build from scratch, Some you should detect and fix its bugs and some you should complete its missing pieces to work properly.

<h3>Before you go</h3>

* Make sure that you're working on Flutter `version 1.22.4` and `stable channel` to avoid any potential unconsistency in code behavior. Run `flutter doctor` before you begin to double check.

* As this project is integrated with some of Firebase services that require SHA-1 key for the running machines in debug mode. We unified a globla SHA-1 key for all our team machines. You need to download this [debug keystore](https://github.com/AKWAD-Dragons/Flutter-Capstone-Project/blob/stage-1/debug.keystore), then replace the `debug.keystore` file in `C:\Users\USERNAME\.android` with the downloaded file.

* As the profile module still one of your tasks to implement. Some dependant functionalities are freezed till it's ready and one of them is creating a profile for a newly registered user. So that, you need an already registered account. Kindly, Use `1026088807` as your mobile number and `123456` as the verification SMS Code.

<h3>Task 0 : Setting up the project using Git</h3>

Before working on this project you need to have your own copy on your Github account. Hence, You should fork it to your account then clone it to your local machine. Once it's up and running you can start working on your local version, commiting and pushing to your remote version. Once you're totally done you will send us the link of your forked repository.

<em>Key notes about Git:</em>

 1- Each module of the following should be worked out in a separate branch.

 2- All branches should be started out of the <b>main</b> branch

 3- Once a branch is done. It should be merged into the <b>main</b> branch

 4- Project final evaluation will be on the final version of the <b>main</b> branch. The other branches are important to evaluate your Git skills but won't be pulled or evaluated.

If your Git knowledge needs a refresher. Here's a 15 mins article that would thrive your skills: https://www.atlassian.com/git

<h3>Task 1: Authentication Module</h3>

In this module you should see this designed flow:

https://www.figma.com/file/GJvHpckBGdncFBPvKsEfyG/Axon-Mobile?node-id=49%3A155


1- In project files tree. Navigate to <em>lib/UI/Auth/auth_Screen.dart</em>

2- [Scenario] We're mainly facing a critical issue creating a new account into Axon system. Once i manage to enter my phone number, I receive an SMS code which i try
to enter in the verification screen to start creating the account. Once i press "Next", Nothing happens and I'm stuck in the verification screen.<span style="color:red">[BUG]</span>

<em>3- Expected:</em>
  * Once i enter the correct OTP code and click the next button i should be navigated to the [complete profile screen](https://cutt.ly/Ihm1QT1) to start creating my account.
  * This task evaluation is binary (Either works or doesn't work)
  * Each line of code should be justified upon discussion.

<h3>Task 2: Routing Module</h3>

1- [Scenario] Once we manage to pass to the [complete profile screen](https://cutt.ly/Ihm1QT1), we noticed that we still can navigate back to the OTP verification screen which is unpleasant behaviour. Because once you're authorized to create a profile, you must not be able to login again unless manually logged yourself out. That's how JWT authentication mechanism works.<span style="color:red">[BUG]</span>

<em>2- Expected:</em>
  * Once I'm in the complete profile screen. I cannot navigate back to any other authentication screen. <br>
  * Pressing the physical back button in Android should force the app to close.<br>
  * Once i open the app again i find the complete profile screen.<br>
  * Manually cleaning the app caches and re-open it scenario is not part of this task.<br>
  * Manually re-installing the app scenario is not part of this task.<br>
  * This task evaluation is binary (Either works or doesn't work)
  * Each line of code should be justified upon discussion.


<h3>Task 3: Profile Module</h3>

In this module you should see this designed flow:

https://www.figma.com/file/GJvHpckBGdncFBPvKsEfyG/Axon-Mobile?node-id=361%3A108

1- In project files tree. Navigate to <em>lib\UI\profile\editPofile\edit_profile_screen.dart</em>

2- Implement the full UI design of the <b>Edit Profile</b> flow according to what is visible in the design link above <span style="color:green">[IMPLEMENTATION]</span>

3- Build the `ProfileService` class located in <em>lib\services\profile.dart</em> & use its functions inside relevant bloc classes to satisfy the required functionalities in point #4. Please refer to the project [GraphQL Documentation](http://167.99.135.109/graphql-playground) for more info about relevant endpoints.

<em>4- Expected Deign should:</em>
  * Validate each field input before submission. Each validation that may help the user take the proper actions are applied <em>(The more, the better)</em>
  * Be responsive with large, medium and small screens.<br>
  * Be responsive with both Arabic & English locales (screen orientations).<br>
  * Be matched with Figma design dimensions in the provided link. <br>

<em>5- Expected functionalities should let User able to:</em>
  * See his current Username & Mobile phone number once navigated to [Settings Screen](https://www.figma.com/file/GJvHpckBGdncFBPvKsEfyG/Axon-Mobile?node-id=171%3A461) <em>(UI already implemented in lib/home/settings_screen.dart)</em>
  * Change his name in DB
  * Change his E-mail Address in DB
  * Change his Birthday date in DB
  * Change his city of residence to a another city from a list of cities provided from DB <em>(It's OK if user chose the same old value)</em>
  * Change his area from a list of cities provided from DB <em>(It's OK if user chose the same old value)</em>
  * See his updated Username right after submitting the prvious profile data. <em>(If i need to reload the screen or the app itself. This point fails)</em>

<em>6- Task evaluation:</em>
  * Each test fail or UI overflow shall affect the task evaluation severely<br>
  * Code should be well organized and readable.<br>
  * Each line of code should be justified upon discussion.
  * UI narrow mismatches might be tolerated in (-/+ 5px) range.

<h3>Task 4: Building Data Models</h3>

1- Once you open the capstone project codebase you'll notice some errors appear on multiple files. <em>Please Don't Panick!</em> It's the <b>Membership</b> Data model has been
truncated out of the project. All these red marked files need this <b>Membership</b> model either as an instance or as a data type. We created this task to help you feel the central role these models play in the software design.

2- The <b>Membership</b> data model should be located with its siblings in <em>lib\PODO</em> folder. <b>PODO</b> stands for <em>Plain Old Dart Object</em>.

3- If you read any of the other models in the PODO folder (as you should also have done previously in a different codebase of ours), you can see it consists of some fields.
You can build these fields of the model by visiting the project [GraphQL Documentation](http://167.99.135.109/graphql-playground) and looking for <b>Membership</b> entity.

4- This task evaluatoion based on code review. However, any red mark errors cannot be tolerated

5- Data model manual serialization (Using dart:convert) shall affect the task evaluation severely. Instead, use the code generation as it is the optimal solution for medium
to large projects. [This Guide](https://flutter.dev/docs/development/data-and-backend/json) may enlighten your way through.

6- Each line of code should be justified upon discussion.


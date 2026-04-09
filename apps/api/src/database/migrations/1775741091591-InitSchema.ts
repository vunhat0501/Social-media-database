import { MigrationInterface, QueryRunner } from "typeorm";

export class InitSchema1775741091591 implements MigrationInterface {
    name = 'InitSchema1775741091591'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "auth" ("id" SERIAL NOT NULL, "hashed_password" character varying, "auth_provider" character varying NOT NULL DEFAULT 'local', "auth_provider_id" character varying, "email_verified" boolean NOT NULL DEFAULT false, "refresh_token" character varying, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "user_id" integer, CONSTRAINT "UQ_c8a9c2d3b54261f286487e1cfb7" UNIQUE ("auth_provider", "auth_provider_id"), CONSTRAINT "UQ_30d7073cf23d5a90f50d4cdc204" UNIQUE ("user_id", "auth_provider"), CONSTRAINT "PK_7e416cf6172bc5aec04244f6459" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "hashtags" ("id" SERIAL NOT NULL, "name" character varying NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "UQ_7fedde18872deb14e4889361d7b" UNIQUE ("name"), CONSTRAINT "PK_994c5bf9151587560db430018c5" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_7fedde18872deb14e4889361d7" ON "hashtags" ("name") `);
        await queryRunner.query(`CREATE TABLE "post_hashtags" ("post_id" integer NOT NULL, "hashtag_id" integer NOT NULL, CONSTRAINT "PK_c605e5a0c23a9e348ae87dde1ff" PRIMARY KEY ("post_id", "hashtag_id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_41f5ee7a97e67023d7461fa8f4" ON "post_hashtags" ("hashtag_id") `);
        await queryRunner.query(`CREATE TABLE "post_media" ("id" SERIAL NOT NULL, "media_url" character varying NOT NULL, "media_type" character varying NOT NULL DEFAULT 'image', "sequence_order" integer NOT NULL DEFAULT '1', "created_at" TIMESTAMP NOT NULL DEFAULT now(), "post_id" integer, CONSTRAINT "PK_049edb1ce7ab3d2a98009b171d0" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "comments" ("id" SERIAL NOT NULL, "content" text NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "user_id" integer, "post_id" integer, CONSTRAINT "PK_8bf68bc960f2b69e818bdb90dcb" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "likes" ("user_id" integer NOT NULL, "post_id" integer NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_723da61de46f65bb3e3096750d2" PRIMARY KEY ("user_id", "post_id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_741df9b9b72f328a6d6f63e79f" ON "likes" ("post_id") `);
        await queryRunner.query(`CREATE TABLE "posts" ("id" SERIAL NOT NULL, "title" text, "status" character varying NOT NULL DEFAULT 'public', "location" text, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "user_id" integer, CONSTRAINT "PK_2829ac61eff60fcec60d7274b9e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "saved_posts" ("user_id" integer NOT NULL, "post_id" integer NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_837a562f71fec3009c9af77ee53" PRIMARY KEY ("user_id", "post_id"))`);
        await queryRunner.query(`CREATE TABLE "follows" ("following_user_id" integer NOT NULL, "followed_user_id" integer NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_127ee66907c5f852d55d7bcda17" PRIMARY KEY ("following_user_id", "followed_user_id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_56a285ecbf4f5f949ea2746f5f" ON "follows" ("followed_user_id") `);
        await queryRunner.query(`CREATE TABLE "stories" ("id" SERIAL NOT NULL, "media_url" character varying NOT NULL, "expires_at" TIMESTAMP NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "user_id" integer, CONSTRAINT "PK_bb6f880b260ed96c452b32a39f0" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_b268ef13743e47999b36cb1470" ON "stories" ("expires_at") `);
        await queryRunner.query(`CREATE TYPE "public"."users_role_enum" AS ENUM('admin', 'user')`);
        await queryRunner.query(`CREATE TABLE "users" ("id" SERIAL NOT NULL, "user_name" character varying NOT NULL, "email" character varying NOT NULL, "role" "public"."users_role_enum" NOT NULL DEFAULT 'user', "avatar_url" character varying, "bio" character varying, "created_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "UQ_074a1f262efaca6aba16f7ed920" UNIQUE ("user_name"), CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE ("email"), CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_074a1f262efaca6aba16f7ed92" ON "users" ("user_name") `);
        await queryRunner.query(`ALTER TABLE "auth" ADD CONSTRAINT "FK_9922406dc7d70e20423aeffadf3" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "post_hashtags" ADD CONSTRAINT "FK_6c16a0f366b0642259bbe50481c" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "post_hashtags" ADD CONSTRAINT "FK_41f5ee7a97e67023d7461fa8f43" FOREIGN KEY ("hashtag_id") REFERENCES "hashtags"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "post_media" ADD CONSTRAINT "FK_1eeb54a4fdfbe9db17899243cbe" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "comments" ADD CONSTRAINT "FK_4c675567d2a58f0b07cef09c13d" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "comments" ADD CONSTRAINT "FK_259bf9825d9d198608d1b46b0b5" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "likes" ADD CONSTRAINT "FK_3f519ed95f775c781a254089171" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "likes" ADD CONSTRAINT "FK_741df9b9b72f328a6d6f63e79ff" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "posts" ADD CONSTRAINT "FK_c4f9a7bd77b489e711277ee5986" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "saved_posts" ADD CONSTRAINT "FK_78c961371a509e86d789714dd4f" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "saved_posts" ADD CONSTRAINT "FK_116e9df57f5221cc1a77c3d1cfe" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "follows" ADD CONSTRAINT "FK_afe636fd5d9cf912133e7eb7aeb" FOREIGN KEY ("following_user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "follows" ADD CONSTRAINT "FK_56a285ecbf4f5f949ea2746f5f2" FOREIGN KEY ("followed_user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "stories" ADD CONSTRAINT "FK_ab4ee230faf536e7c5aee12f4ea" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "stories" DROP CONSTRAINT "FK_ab4ee230faf536e7c5aee12f4ea"`);
        await queryRunner.query(`ALTER TABLE "follows" DROP CONSTRAINT "FK_56a285ecbf4f5f949ea2746f5f2"`);
        await queryRunner.query(`ALTER TABLE "follows" DROP CONSTRAINT "FK_afe636fd5d9cf912133e7eb7aeb"`);
        await queryRunner.query(`ALTER TABLE "saved_posts" DROP CONSTRAINT "FK_116e9df57f5221cc1a77c3d1cfe"`);
        await queryRunner.query(`ALTER TABLE "saved_posts" DROP CONSTRAINT "FK_78c961371a509e86d789714dd4f"`);
        await queryRunner.query(`ALTER TABLE "posts" DROP CONSTRAINT "FK_c4f9a7bd77b489e711277ee5986"`);
        await queryRunner.query(`ALTER TABLE "likes" DROP CONSTRAINT "FK_741df9b9b72f328a6d6f63e79ff"`);
        await queryRunner.query(`ALTER TABLE "likes" DROP CONSTRAINT "FK_3f519ed95f775c781a254089171"`);
        await queryRunner.query(`ALTER TABLE "comments" DROP CONSTRAINT "FK_259bf9825d9d198608d1b46b0b5"`);
        await queryRunner.query(`ALTER TABLE "comments" DROP CONSTRAINT "FK_4c675567d2a58f0b07cef09c13d"`);
        await queryRunner.query(`ALTER TABLE "post_media" DROP CONSTRAINT "FK_1eeb54a4fdfbe9db17899243cbe"`);
        await queryRunner.query(`ALTER TABLE "post_hashtags" DROP CONSTRAINT "FK_41f5ee7a97e67023d7461fa8f43"`);
        await queryRunner.query(`ALTER TABLE "post_hashtags" DROP CONSTRAINT "FK_6c16a0f366b0642259bbe50481c"`);
        await queryRunner.query(`ALTER TABLE "auth" DROP CONSTRAINT "FK_9922406dc7d70e20423aeffadf3"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_074a1f262efaca6aba16f7ed92"`);
        await queryRunner.query(`DROP TABLE "users"`);
        await queryRunner.query(`DROP TYPE "public"."users_role_enum"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_b268ef13743e47999b36cb1470"`);
        await queryRunner.query(`DROP TABLE "stories"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_56a285ecbf4f5f949ea2746f5f"`);
        await queryRunner.query(`DROP TABLE "follows"`);
        await queryRunner.query(`DROP TABLE "saved_posts"`);
        await queryRunner.query(`DROP TABLE "posts"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_741df9b9b72f328a6d6f63e79f"`);
        await queryRunner.query(`DROP TABLE "likes"`);
        await queryRunner.query(`DROP TABLE "comments"`);
        await queryRunner.query(`DROP TABLE "post_media"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_41f5ee7a97e67023d7461fa8f4"`);
        await queryRunner.query(`DROP TABLE "post_hashtags"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_7fedde18872deb14e4889361d7"`);
        await queryRunner.query(`DROP TABLE "hashtags"`);
        await queryRunner.query(`DROP TABLE "auth"`);
    }

}

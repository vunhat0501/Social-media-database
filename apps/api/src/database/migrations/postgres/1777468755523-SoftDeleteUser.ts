import { MigrationInterface, QueryRunner } from "typeorm";

export class SoftDeleteUser1777468755523 implements MigrationInterface {
    name = 'SoftDeleteUser1777468755523'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "users" ADD "deleted_at" TIMESTAMP`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "deleted_at"`);
    }

}
